//
//  AllBellView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/15.
//

import SwiftUI

struct AllBellView: View {
    var firstTime: Int
    var secondTime: Int
    var thirdTime: Int
    let firstButtonAction: () -> Void
    let secondButtonAction: () -> Void
    let thirdButtonAction: () -> Void
    var body: some View {
        Grid {
            GridRow {
                FirstBellView(buttonText: converterTimerTextFromSecond(second: firstTime)) {
                    firstButtonAction()
                }
            }

            GridRow {
                SecondBellView(buttonText: converterTimerTextFromSecond(second: secondTime)) {
                    secondButtonAction()
                }
            }
            GridRow {
                ThirdBellView(buttonText: converterTimerTextFromSecond(second: thirdTime)) {
                    thirdButtonAction()
                }
            }
        }
    }

    func converterTimerTextFromSecond(second: Int) -> String {
        let time = TimeConverter.secondsToHoursMinutes(seconds: second)
        if time.hour == 0 && time.minute == 0{
            return "\(time.second)秒"
        }else if time.hour == 0 {
            return "\(time.minute)分\(time.second)秒"
        } else {
            return "\(time.hour)時間\(time.minute)分\(time.second)秒"
        }
    }
}

struct AllBellView_Previews: PreviewProvider {
    static var previews: some View {
        AllBellView(
            firstTime: 10, secondTime: 10, thirdTime: 10, firstButtonAction: {}, secondButtonAction: {}, thirdButtonAction: {}
        )
    }
}
