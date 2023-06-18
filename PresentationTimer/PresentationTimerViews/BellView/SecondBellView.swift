//
//  SecondBellView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/15.
//

import SwiftUI

struct SecondBellView: View {
    let buttonText: String
    let buttonAction: () -> Void
    var body: some View {
        GeometryReader { geometry in
            HStack {
                HStack {
                    BellImage()
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

struct SecondBellView_Previews: PreviewProvider {
    static var previews: some View {
        SecondBellView(buttonText: "Second") {}
    }
}
