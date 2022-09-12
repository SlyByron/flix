//
//  MovieDetailsViewModel.swift
//  Flix
//
//  Created by Byron on 11/09/2022.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {

  /// The repository for fetching movie details
  var movieRepository: MovieRepository
  @Published private(set) var movie: Movie

  init(movie: Movie, movieRepository: MovieRepository) {
    self.movie = movie
    self.movieRepository = movieRepository
    // get more details for movie
    Task {
      do {
        let movie = try await movieRepository.details(id: movie.id)
        DispatchQueue.main.async {
          self.movie = movie
        }
      } catch {
        log.error("Failed to get movie details: \(error)")
      }
    }
  }
}
