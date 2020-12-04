//
//  Collection.swift
//  SwiftUIPHPickerApp
//
//
//

import SwiftUI

struct Collection<Content: View, Data: Hashable>: View {
  var data: [Data]

  let viewBuilder: (Data, Int) -> Content
  let initialView: (() -> (AnyView))?
  let cols: Int
  let spacing: CGFloat
  private var collectionData = [Any]()

  init(
    data: [Data],
    cols: Int = 2, spacing: CGFloat = 16,
    initialView: (() -> AnyView)? = nil,
    _ viewBuilder: @escaping (Data, Int) -> Content
  ) {
    self.data = data
    self.cols = cols
    self.spacing = spacing
    self.viewBuilder = viewBuilder
    self.initialView = initialView
  }

  var body: some View {
    let collectionData = self.initialView != nil ? [nil] + self.data as [Any] : self.data

    GeometryReader { geometry in
      ScrollView {
        self.setupView(geometry: geometry, collectionData: collectionData).frame(
          minHeight: geometry.frame(in: .global).height
        )
      }
    }
  }

  private func setupView(geometry: GeometryProxy, collectionData: [Any]) -> some View {
    let dataCount = collectionData.count
    let rowRemainder = Double(dataCount).remainder(dividingBy: Double(cols))
    let rowCount = dataCount / cols + (rowRemainder == 0 ? 0 : 1)
    let frame = geometry.frame(in: .global)
    let totalSpacing = Int(spacing) * (cols - 1)
    let cellWidth = (frame.width - CGFloat(totalSpacing)) / CGFloat(cols)

    return VStack(alignment: .leading, spacing: spacing) {
      ForEach(0 ... rowCount - 1, id: \.self) { row in
        HStack(spacing: self.spacing) {
          ForEach(0 ... self.cols - 1, id: \.self) { col in
            if self.initialView != nil, row == 0, col == 0 {
              self.initialView?().frame(maxWidth: cellWidth)
            } else {
              self.cell(colIndex: col, rowIndex: row, collectionData: collectionData)
                .frame(maxWidth: cellWidth)
            }
          }
        }
      }
      Spacer()
    }
  }

  private func cell(colIndex: Int, rowIndex: Int, collectionData: [Any]) -> some View {
    let cellIndex = (rowIndex * cols) + colIndex
    return ZStack {
      if cellIndex < collectionData.count {
        self.viewBuilder(collectionData[cellIndex] as! Data, cellIndex)
      }
    }
  }
}
