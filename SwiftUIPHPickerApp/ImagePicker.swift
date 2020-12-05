//
//  ImagePicker.swift
//  SwiftUIPHPickerApp
//
//  Copyright © 2020 manato. All rights reserved.
//

import PhotosUI
import SwiftUI

// Import PromiseKit
import PromiseKit

enum ImageError: Error {
  case unwrapped
}

struct ImagePicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  let configuration: PHPickerConfiguration

  // Return array of UIImage
  let completion: (_ selectedImage: [UIImage]) -> Void

  func makeUIViewController(context: Context) -> PHPickerViewController {
    let controller = PHPickerViewController(configuration: configuration)
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_: PHPickerViewController, context _: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: PHPickerViewControllerDelegate {
    let parent: ImagePicker

    init(_ parent: ImagePicker) {
      self.parent = parent
    }

    func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      Promise.value(results).thenMap(load).done { images in
        self.parent.completion(images)
      }.catch { error in
        print(error.localizedDescription)
      }
      parent.presentationMode.wrappedValue.dismiss()
    }

    // Return the loaded value wrapped Promise
    private func load(_ image: PHPickerResult) -> Promise<UIImage> {
      Promise { seal in
        image.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, error in
          if let error = error {
            print(error.localizedDescription)
            seal.reject(error)
            return
          }

          guard let uiImage = selectedImage as? UIImage else {
            print("unable to unwrap image as UIImage")
            seal.reject(ImageError.unwrapped)
            return
          }

          // .fulfill to resolve the value
          seal.fulfill(uiImage)
        }
      }
    }
  }
}
