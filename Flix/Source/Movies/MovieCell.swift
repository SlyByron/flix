//
//  MovieCell.swift
//  Flix
//
//  Created by Byron on 11/09/2022.
//

import SwiftUI

/// View for displaying movie information in a list
struct MovieCell: View {
  let movie: Movie
  var body: some View {
    HStack(spacing: 20) {
      AsyncImage(url: movie.posterURL()) { phase in
        switch phase {
        case .empty:
          ProgressView()
            .progressViewStyle(.circular)
        case .success(let image):
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        case .failure:
          Color.gray
        @unknown default:
          Color.red // more obvious a case is not handled
        }
      }
      .frame(width: 70, height: 110)
      VStack(alignment: .leading, spacing: 6) {
        Text(movie.title)
          .font(.headline)
        Text(movie.releaseDate)
          .font(.subheadline)
      }
      Spacer()
    }
  }
}

struct MovieCell_Previews: PreviewProvider {
  static var previews: some View {
    MovieCell(movie: Movie(
      id: 1,
      title: "A delightful movie",
      releaseDate: "01/02/2022",
      poster: "",
      backdrop: "",
      overview: "lots of info"
    ))
  }
}
