//
//  Service.swift
//  Flix
//
//  Created by Byron on 10/09/2022.
//

import Foundation

/// A protocol to define a service that interacts with an API using the RESTful architecture
protocol RESTService {

  /// Generic GET request to the api, passing in the desired endpoint of the request
  /// - Parameter endpoint: the endpoint specific to the desired API call
  /// - Returns: A decoded object of the given type for this request
  func get<T: Decodable>(endpoint: Endpoint) async throws -> T
}
