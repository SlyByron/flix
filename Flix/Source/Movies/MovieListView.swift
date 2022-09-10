//
//  MovieListView.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import SwiftUI

/// The view to be able to view a list of movies
struct MovieListView: View {

  /// The view model backing this view
  @StateObject var viewModel: MovieListViewModel

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.movies) { movie in
          VStack {
            Text(movie.title)
          }.onAppear {
            viewModel.paginationUpdate(movie: movie)
          }
        }
        // show spinner when needed
        if viewModel.fetchingMovies {
          HStack(alignment: .center) {
            Spacer()
            ProgressView().progressViewStyle(.circular)
            Spacer()
          }
        }
      }
      .listStyle(.plain)
      .navigationBarTitle("Movies")
    }
    .task {
      // get all movies to display in the list
      await viewModel.fetchMovies()
    }
  }
}
