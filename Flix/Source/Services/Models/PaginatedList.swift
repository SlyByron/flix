//
//  PaginatedList.swift
//  Flix
//
//  Created by Byron on 09/09/2022.
//

import Foundation

/// A list of results that are paginated
struct PaginatedList<T: Decodable>: Decodable {

  /// The current page of the results
  let page: Int
  /// The results for this page
  let results: [T]
  /// how many results there are in total
  let totalResults: Int
  /// how many pages there are in total
  let totalPages: Int

  enum CodingKeys: String, CodingKey {
    case page = "page"
    case results = "results"
    case totalResults = "total_results"
    case totalPages = "total_pages"
  }
}

// A paginated list of movies
typealias MoviePaginatedList = PaginatedList<Movie>
