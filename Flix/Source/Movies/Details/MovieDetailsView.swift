//
//  MovieDetailsView.swift
//  Flix
//
//  Created by Byron on 11/09/2022.
//

import SwiftUI

/// View for additional details about a Movie
struct MovieDetailsView: View {

  /// The view model backing this view
  @StateObject var viewModel: MovieDetailsViewModel

  var body: some View {
    // banner
    AsyncImage(url: viewModel.movie.backdropURL()) { phase in
      switch phase {
      case .empty:
        ProgressView()
          .progressViewStyle(.circular)
      case .success(let image):
        image
          .resizable()
          .frame(height: 400)
          .aspectRatio(contentMode: .fill)
      case .failure:
        Color.gray
      @unknown default:
        Color.red // more obvious a case is not handled
      }
    }
    // main content
    ScrollView {
      VStack(alignment: .leading, spacing: 36.0) {
        VStack(alignment: .leading, spacing: 16.0) {
          Text(viewModel.movie.title)
            .font(.title)
          viewModel.movie.tagline.map(Text.init)
            .font(.headline)
            .foregroundColor(.gray)
          Divider()
          VStack(alignment: .leading) {
            Text("Duration:")
              .font(.caption)
              .foregroundColor(.secondary)
            Text(viewModel.movie.formattedRuntime())
              .font(.subheadline)
          }
          Divider()
          Text(viewModel.movie.overview)
            .font(.body)
        }
        Spacer()
      }
    }
    .padding(.top, 18)
    .padding(.horizontal, 20)
    .navigationBarTitleDisplayMode(.inline)
  }
}
