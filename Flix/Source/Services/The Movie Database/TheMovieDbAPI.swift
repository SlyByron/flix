//
//  TheMovieDbAPI.swift
//  Flix
//
//  Created by Byron on 07/09/2022.
//

import Foundation
import SwiftUI

extension URL {
  static var theMovieDbBaseURL: URL {
    URL(string: "https://api.themoviedb.org/3")!
  }
}

/// Handles requests to The Movie Database API
/// https://developers.themoviedb.org/3/
final actor TheMovieDbAPI {

  private var apiKey: String
  private let baseURL = URL.theMovieDbBaseURL
  private let urlSession = URLSession.shared
  private let decoder = JSONDecoder()

  /// Instantiates this class with an api key, that is provided specifically for a particular app
  /// - Parameter apiKey: The app specific api key for The Movie Database
  init(apiKey: String) {
    self.apiKey = apiKey
  }

  /// Generic request to the api, passing in the desired endpoint of the request
  /// - Parameter endpoint: the URL specific to the desired API call
  /// - Returns: A decoded object of the given type for this request
  func get<T: Decodable>(endpoint: URL) async throws -> T {

    // build url
    let url = baseURL.appendingPathComponent(endpoint.path)
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    var queryItems = components?.queryItems ?? []
    queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
    components?.queryItems = queryItems

    guard let components = components, let requestURL = components.url else {
      throw TheMovieDbError.malformed
    }

    // make request
    let request = URLRequest(url: requestURL)
    let data: Data
    let response: URLResponse

    do {
      (data, response) = try await urlSession.data(for: request)
    } catch {
      throw error
    }

    // validate response
    let status = (response as? HTTPURLResponse)?.statusCode ?? -1
    if status != 200 { // handle response errors
      switch status {
      case 401:
        throw TheMovieDbError.unauthorized
      case 404:
        throw TheMovieDbError.notFound
      default:
        throw TheMovieDbError.unknown
      }
    }

    // decode response data
    let result: T
    do {
      result = try decoder.decode(T.self, from: data)
    } catch {
      throw TheMovieDbError.decode
    }
    return result
  }
}

// MARK: Errors

/// Errors specific to communication with the Movie Database API
public enum TheMovieDbError: Error {
  case malformed
  case request(Error)
  case unauthorized
  case notFound
  case decode
  case unknown
}

extension TheMovieDbError: LocalizedError {

  /// A description for what the error relates to
  public var errorDescription: String? {
    switch self {
    case .malformed:
      return "malformed request"
    case .request(let error):
      return "error making request: \(error.localizedDescription)"
    case .unauthorized:
      return "error authorising request"
    case .notFound:
      return "nothing found for request"
    case .decode:
      return "error decoding response data"
    case .unknown:
      return "unknown error occured"
    }
  }
}
