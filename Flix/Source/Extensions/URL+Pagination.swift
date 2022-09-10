//
//  URL+Pagination.swift
//  Flix
//
//  Created by Byron on 10/09/2022.
//

import Foundation

extension URL {

  /// Returns a URL by appending the specified page query item to itself
  /// - Parameter page: the page query item to add
  /// - Returns: URL with appended page query item
  func appendingPage(_ page: Int?) -> Self {
    guard let page = page else {
      log.warning("no page element to append to URL")
      return self
    }
    var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
    var queryItems = components.queryItems ?? []
    queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
    components.queryItems = queryItems
    return components.url!
  }
}
