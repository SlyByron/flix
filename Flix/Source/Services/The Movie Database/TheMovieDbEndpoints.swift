//
//  TheMovieDbEndpoints.swift
//  Flix
//
//  Created by Byron on 10/09/2022.
//

import Foundation

enum MoviesEndpoint {
  case popular(page: Int? = nil)
  case upcoming(page: Int? = nil)
}

extension MoviesEndpoint: Endpoint {

  private static let basePath = URL(string: "/movie")!

  var url: URL {
    switch self {
    case .popular(let page):
      return Self.basePath
        .appendingPathComponent("popular")
        .appendingPage(page)
    case .upcoming(let page):
      return Self.basePath
        .appendingPathComponent("upcoming")
        .appendingPage(page)
    }
  }
}
