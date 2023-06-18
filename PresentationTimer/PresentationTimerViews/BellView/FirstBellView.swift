//
//  FirstBellView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/15.
//

import SwiftUI

struct FirstBellView: View {
    let buttonText: String
    let buttonAction: () -> Void
    var body: some View {
        GeometryReader { geometry in
            HStack {
                HStack {
                    BellImage()
                }
                .frame(
                    width: geometry.size.width / 2,
                    height: geometry.size.height
                )
                Button {
                    buttonAction()
                } label: {
                    Text(buttonText)
                }
                .frame(
                    width: geometry.size.width / 2,
                    height: geometry.size.height
                )
            }
        }
    }
}

struct FirstBellView_Previews: PreviewProvider {
    static var previews: some View {
        FirstBellView(buttonText: "First") {
            print("First")
        }
    }
}
