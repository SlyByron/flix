//
//  MovieListViewModel.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import Foundation

/// The view model backing the movie list
class MovieListViewModel: ObservableObject {

  var movieRepository: MovieRepository

  @Published private(set) var movies: [Movie] = []

  init(movieRepository: MovieRepository) {
    self.movieRepository = movieRepository
  }

  func fetchMovies() async {
    do {
      let paginatedMovies: MoviePaginatedList = try await movieRepository.popular()
      movies = paginatedMovies.results
    } catch {
      log.error("Error fetching movie data from repository: \(error)")
    }
  }
}
