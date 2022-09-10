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

  func makeMovieListViewModel() -> MovieListViewModel {
    return MovieListViewModel(
      movieRepository: MovieRepository(theMovieDbService: movieDBService)
    )
  }
}
