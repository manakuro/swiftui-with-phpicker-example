//
//  ContentView.swift
//  SwiftUIPHPickerApp
//
//  Copyright © 2020 manato. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var images: [ImageListItem] = [
    ImageListItem(id: 1, image: UIImage(named: "cat-img")!),
    ImageListItem(id: 2, image: UIImage(named: "cat-img")!),
    ImageListItem(id: 3, image: UIImage(named: "cat-img")!),
    ImageListItem(id: 4, image: UIImage(named: "cat-img")!),
  ]

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Button(action: {}) {
            Text("Add photos")
          }
          Spacer()
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
