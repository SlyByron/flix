//
//  TheMovieDbAPITests.swift
//  FlixTests
//
//  Created by Byron on 07/09/2022.
//

import XCTest
@testable import Flix

class TheMovieDbAPITests: XCTestCase {

  let testAPIURL = URL(string: "https://url.test")!
  var testDBAPI: TheMovieDbAPI!

  override func setUpWithError() throws {

    let config = URLSessionConfiguration.default
    config.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: config)

    testDBAPI = TheMovieDbAPI(
      apiKey: "testKEY",
      baseURL: testAPIURL,
      urlSession: session
    )
  }

  func testSuccessfulRequest() async throws {

    let json: [String: Any] = [
      "testString": "success",
      "testInt": 12
    ]
    let responseData = try JSONSerialization.data(withJSONObject: json)

    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: self.testAPIURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, responseData)
    }

    let testEndpoint = URL(string: "test/endpoint")!
    let result: TestResponseData = try await testDBAPI.get(endpoint: testEndpoint)
    XCTAssertEqual(result.testString, "success")
    XCTAssertEqual(result.testInt, 12)
  }

  func testUnaithorizedRequest() async throws {
    let json: [String: Any] = [
      "testString": "success",
      "testInt": 12
    ]
    let responseData = try JSONSerialization.data(withJSONObject: json)

    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(url: self.testAPIURL, statusCode: 401, httpVersion: nil, headerFields: nil)!
      return (response, responseData)
    }

    let testEndpoint = URL(string: "test/endpoint/////")!
    do {
      let _: TestResponseData = try await testDBAPI.get(endpoint: testEndpoint)
    } catch {
      if let error = error as? TheMovieDbError {
        XCTAssertEqual(error.errorDescription, TheMovieDbError.unauthorized.errorDescription)
      } else {
        XCTFail("failed to receive relevant error")
      }
    }
  }
}

/// Test response model
class TestResponseData: Decodable {
  var testString: String
  var testInt: Int
}

/// Basic mock protocol to handle the nertwork requests
class MockURLProtocol: URLProtocol {

  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    guard let handler = MockURLProtocol.requestHandler else {
      fatalError("Handler unavailable")
    }
    do {
      let (response, data) = try handler(request)

      // send response
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

      if let data = data {
        // send data
        client?.urlProtocol(self, didLoad: data)
      }

      // finish up
      client?.urlProtocolDidFinishLoading(self)
    } catch {
      // handle any errors
      client?.urlProtocol(self, didFailWithError: error)
    }
  }
  override func stopLoading() {

  }
}
