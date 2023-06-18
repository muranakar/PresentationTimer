//
//  BellImage.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/15.
//

import SwiftUI

struct BellImage: View {
    var body: some View {
        Image("bell2")
            .resizable()
            .scaledToFit()
            .frame(width: 30,height: 30)
    }
}

struct BellImage_Previews: PreviewProvider {
    static var previews: some View {
        BellImage()
    }
}
