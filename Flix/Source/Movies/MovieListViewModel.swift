//
//  MovieListViewModel.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import Foundation

/// The view model backing the movie list
class MovieListViewModel: ObservableObject {

  @Published private(set) var movies: [Movie]

  init() {
    movies = [
      Movie(title: "Lord of the Rings"),
      Movie(title: "Matrix"),
      Movie(title: "Shrek")
    ]
  }
}
