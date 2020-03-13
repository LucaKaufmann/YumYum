//
//  NetworkImage.swift
//  YumYum
//
//  Created by Luca Kaufmann on 24/07/2019.
//  Copyright © 2019 Luca Kaufmann. All rights reserved.
// https://gist.github.com/ivanbruel/b2838f62cb281bd974ec9c9c121c6cbe

import SwiftUI
import Kingfisher
import UIKit

public struct NetworkImage: SwiftUI.View {

  // swiftlint:disable:next redundant_optional_initialization
  @State private var image: UIImage? = nil

  public let imageURL: URL?
  public let placeholderImage: UIImage
    public let animation: Animation = .default

  public var body: some SwiftUI.View {
    Image(uiImage: image ?? placeholderImage)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .onAppear(perform: loadImage)
      .transition(.opacity)
      .id(image ?? placeholderImage)
  }

  private func loadImage() {
    guard let imageURL = imageURL, image == nil else { return }
    KingfisherManager.shared.retrieveImage(with: imageURL) { result in
      switch result {
      case .success(let imageResult):
        withAnimation(self.animation) {
          self.image = imageResult.image
        }
      case .failure:
        break
      }
    }
  }
}

#if DEBUG
// swiftlint:disable:next type_name
struct NetworkImage_Previews: PreviewProvider {
  static var previews: some SwiftUI.View {
    NetworkImage(imageURL: URL(string: "https://www.apple.com/favicon.ico")!,
                 placeholderImage: UIImage(systemName: "bookmark")!)
  }
}
#endif
