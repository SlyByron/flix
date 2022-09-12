//
//  MovieListView.swift
//  Flix
//
//  Created by Byron on 08/09/2022.
//

import SwiftUI

/// The view to be able to view a list of moviesd
struct MovieListView: View {

  /// The view model backing this view
  @StateObject var viewModel: MovieListViewModel
  @EnvironmentObject private var vmFactory: ViewModelFactory

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.movies) { movie in
          NavigationLink(
            destination: MovieDetailsView(
              viewModel: vmFactory.makeMovieDetailsViewModel(movie: movie)
            )
          ) {
            MovieCellView(movie: movie)
          }
          .onAppear {
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
      .navigationBarTitle("Popular")
    }
    .task {
      // get all movies to display in the list
      await viewModel.fetchMovies()
    }
  }
}
