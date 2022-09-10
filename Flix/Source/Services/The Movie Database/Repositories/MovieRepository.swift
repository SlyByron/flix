//
//  MovieRepository.swift
//  Flix
//
//  Created by Byron on 09/09/2022.
//

import Foundation

/// A pepository for handling all requests relating to movies
class MovieRepository {

  private let endpoint = URL(string: "/movie/popular")!
  private var theMovieDbService: TheMovieDbService

  /// Initialises the movie repository with a service to interact with to get the relevant movie information
  /// - Parameter theMovieDbService: the service providing movie information
  init(theMovieDbService: TheMovieDbService) {
    self.theMovieDbService = theMovieDbService
  }

  func popular(page: Int = 1) async throws -> MoviePaginatedList {
    try await theMovieDbService.get(endpoint: endpoint)
  }
}
