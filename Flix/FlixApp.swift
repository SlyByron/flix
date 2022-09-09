//
//  FlixApp.swift
//  Flix
//
//  Created by Byron on 06/09/2022.
//

import SwiftUI
import SwiftyBeaver

// Global Logger
let log = SwiftyBeaver.self

@main
struct FlixApp: App {

  @StateObject private var viewModelFactory = ViewModelFactory()

  init() {
    configureLogging()
    log.info("Hello World")
  }

  private func configureLogging() {

    // configure console logging
    let console = ConsoleDestination()
    console.format = "$DHH:mm:ss$d $L $M"
    console.minLevel = .debug
    console.levelString.verbose = "🤖"
    console.levelString.debug = "🪲"
    console.levelString.info = "ℹ️"
    console.levelString.warning = "⚠️"
    console.levelString.error = "⛔️ OH NO!"

    let file = FileDestination()

    log.addDestination(console)
    log.addDestination(file)
  }

  var body: some Scene {
    WindowGroup {
      MovieListView(viewModel: viewModelFactory.makeMovieListViewModel())
    }
  }
}
