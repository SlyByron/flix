//
//  MovieRepository.swift
//  Flix
//
//  Created by Byron on 09/09/2022.
//

import Foundation

/// A pepository for handling all requests relating to movies
class MovieRepository {

  private var service: RESTService

  /// Initialises the movie repository with a service to interact with to get the relevant movie information
  /// - Parameter service: the service providing movie information
  init(service: RESTService) {
    self.service = service
  }

  /// Get a list of the current popular movies
  /// - Parameter page: page to fetch - defaults to 1
  /// - Returns: paginated list of movies
  func popular(page: Int = 1) async throws -> MoviePaginatedList {
    try await service.get(endpoint: MoviesEndpoint.popular(page: page))
  }

  /// Get a list of upcoming movies in theatres
  /// - Parameter page: page to fetch - defaults to 1
  /// - Returns: paginated list of movies
  func upcoming(page: Int = 1) async throws -> MoviePaginatedList {
    try await service.get(endpoint: MoviesEndpoint.upcoming(page: page))
  }
}
