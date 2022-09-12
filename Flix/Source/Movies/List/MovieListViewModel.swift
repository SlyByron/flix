//
//  MovieListViewModel.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import Foundation

/// The view model backing the movie list
class MovieListViewModel: ObservableObject {

  /// The repository for fetching movies
  var movieRepository: MovieRepository
  @Published private(set) var movies: [Movie] = []

  /// whether there are more movies available to fetch
  var availableMovies = true

  private var nextPage = 1
  var fetchingMovies = false

  /// Create a view model with the logic to provide a list of movies, with pagination.
  /// - Parameters:
  ///   - movieRepository: repository to get movie information
  ///   - type: the type of movie list
  init(movieRepository: MovieRepository) {
    self.movieRepository = movieRepository
  }

  /// fetch the next page of movies
  func fetchMovies() async {
    if availableMovies {
      fetchingMovies = true
      do {
        let paginatedMovies: MoviePaginatedList = try await movieRepository.popular(page: nextPage)
        nextPage = paginatedMovies.page + 1
        availableMovies = nextPage <= paginatedMovies.totalPages
        DispatchQueue.main.async {
          self.movies.append(contentsOf: paginatedMovies.results)
        }
        fetchingMovies = false
      } catch {
        log.error("Error fetching movie data from repository: \(error)")
        fetchingMovies = false
      }
    }
  }

  // determine whether more movies should be fetched
  // fetch more movies ahead of time before last movie is accessed
  func paginationUpdate(movie: Movie) {
    if !fetchingMovies {
      guard movies.last == movie else {
        log.verbose("pagination update - not last item")
        return
      }
      log.info("pagination update - getting next page of movies")
      Task {
        await fetchMovies()
      }
    }
  }
}
