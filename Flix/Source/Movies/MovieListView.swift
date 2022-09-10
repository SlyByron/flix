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
          Text(movie.title)
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
