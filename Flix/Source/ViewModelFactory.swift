//
//  ViewModelFactory.swift
//  Flix
//
//  Created by Byron on 09/09/2022.
//

import Foundation

/* The API key should not be stored in code, normally this would be part of a build rule/script on CI
 and entered manually during development with the use of an environment variable, not commited to the repo.
 Having this here for the demo makes it easier to distribute and run but this is bad in a production app */
private let tmdbAPIKey = "716b8b23cfb7a1b566eb35653fc539d9"

/// Factory class responsible for constructing view models
class ViewModelFactory: ObservableObject {

  private let movieDBService = TheMovieDbService(apiKey: tmdbAPIKey)

  /// Creates a view model for movie list
  /// - Returns: a fresh instance of a MovieListViewModel
  func makeMovieListViewModel() -> MovieListViewModel {
    return MovieListViewModel(
      movieRepository: MovieRepository(service: movieDBService)
    )
  }

  /// Creates a view model for movie details
  /// - Parameter movie: the movie with the details
  /// - Returns: a fresh instance of MovieDetailsViewModel
  func makeMovieDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
    return MovieDetailsViewModel(
      movie: movie,
      movieRepository: MovieRepository(service: movieDBService)
    )
  }
}
