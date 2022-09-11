//
//  Movie.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import Foundation

/// Model object for a particular movie
struct Movie: Decodable, Equatable, Identifiable {

  /// unique identifier for this movie
  var id: Int
  /// The title of the movie
  var title: String
  /// The date the movie was releases
  var releaseDate: String
  /// Path to a poster for this movie
  var poster: String?
  /// Path to a backdrop picture for this movie
  var backdrop: String?
  /// brief overview of what the movie is about
  var overview: String

  /// JSON key to variable mappings
  enum CodingKeys: String, CodingKey {
    case id
    case title = "original_title"
    case releaseDate = "release_date"
    case poster = "poster_path"
    case backdrop = "backdrop_path"
    case overview
  }
}

extension Movie {

  private static let basePosterURL = "https://image.tmdb.org/t/p/w185"
  private static let baseBackdropURL = "https://image.tmdb.org/t/p/w185"

  func posterURL() -> URL? {
    guard let posterPath = poster else {
      log.warning("unable to resolve posterURL - no image path")
      return nil
    }
    return URL(string: Movie.basePosterURL.appending(posterPath))
  }
  func backdropURL() -> URL? {
    guard let backdropPath = backdrop else {
      log.warning("unable to resolve backdropURL - no image path")
      return nil
    }
    return URL(string: Movie.baseBackdropURL.appending(backdropPath))
  }
}
