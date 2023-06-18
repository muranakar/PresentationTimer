//
//  StartButton.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let action: () -> Void
    var body: some View {
        VStack {
            Button(action: {
                action()
            }, label: {
                Text(text)
            })
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.title)
        }
    }
}

struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "ボタン", action: {
        })
    }
}
