//
//  Endpoint.swift
//  Flix
//
//  Created by Byron on 10/09/2022.
//

import Foundation

/// The endpoint for a specific API request
protocol Endpoint {
  /// the url representation of the endpoint
  var url: URL { get }
}
