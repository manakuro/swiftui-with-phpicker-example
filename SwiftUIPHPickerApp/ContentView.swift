//
//  ContentView.swift
//  SwiftUIPHPickerApp
//
//  Copyright © 2020 manato. All rights reserved.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
  @State var images: [ImageListItem] = [
    ImageListItem(id: 1, image: UIImage(named: "cat-img")!),
    ImageListItem(id: 2, image: UIImage(named: "cat-img")!),
    ImageListItem(id: 3, image: UIImage(named: "cat-img")!),
    ImageListItem(id: 4, image: UIImage(named: "cat-img")!),
  ]
  @State var showPhotoLibrary = false

  var pickerConfiguration: PHPickerConfiguration {
    var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    config.filter = .images
    config.selectionLimit = 10
    return config
  }

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Button(action: {
            showPhotoLibrary = true
          }) {
            Text("Add photos")
          }
          Spacer()
        }.sheet(isPresented: $showPhotoLibrary) {
          ImagePicker(configuration: pickerConfiguration) { selectedImage in
            images += selectedImage.map { ImageListItem(id: images.count + 1, image: $0) }
          }
        }

        Collection(data: images, cols: 3, spacing: 4) { data, _ in
          Image(uiImage: data.image)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
        }
      }.navigationBarTitle("PHPicker App", displayMode: .inline).padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
