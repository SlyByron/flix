//
//  ViewModelFactory.swift
//  Flix
//
//  Created by Byron on 09/09/2022.
//

import Foundation

/// Factory class responsible for constructing view models
class ViewModelFactory: ObservableObject {

  func makeMovieListViewModel() -> MovieListViewModel {
    return MovieListViewModel()
  }
}
