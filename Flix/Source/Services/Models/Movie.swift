//
//  Movie.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import Foundation

/// Model object for a particular movie
struct Movie: Decodable {

  /// The title of the movie
  var title: String

  /// JSON key to variable mappings
  enum CodingKeys: String, CodingKey {
    case title = "original_title"
  }
}

extension Movie: Identifiable {
  var id: String { title }
}
