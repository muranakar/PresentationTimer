//
//  RemainTimerText.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/15.
//

import SwiftUI

struct RemainTimerText: View {
    @Binding var remainingTime: Int
    var body: some View {
        Text("\(remainingTime / 60):\(remainingTime % 60, specifier: "%02d")")
            .font(.system(size: 100, weight: .black, design: .default))
    }
}

struct RemainTimerText_Previews: PreviewProvider {
    static var previews: some View {
        RemainTimerText(remainingTime: .constant(1000))
    }
}
