//
//  ViewModelFactory.swift
//  Flix
//
//  Created by Byron on 09/09/2022.
//

import Foundation

/// Factory class responsible for constructing view models
class ViewModelFactory: ObservableObject {

  private let movieDBService = TheMovieDbService(apiKey: "716b8b23cfb7a1b566eb35653fc539d9")

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
