//
//  SwiftUIPHPickerAppApp.swift
//  SwiftUIPHPickerApp
//
//
//

import SwiftUI

@main
struct SwiftUIPHPickerAppApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }

  init() {
    setupAppearance()
  }

  func setupAppearance() {
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithTransparentBackground()
      appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
      appearance.backgroundColor = UIColor.white

      // button
      let backButton = UIBarButtonItemAppearance()
      backButton.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
      appearance.backButtonAppearance = backButton

      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
      UINavigationBar.appearance().compactAppearance = appearance
    } else {
      UINavigationBar.appearance().barTintColor = .white
      UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
      UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
  }
}
