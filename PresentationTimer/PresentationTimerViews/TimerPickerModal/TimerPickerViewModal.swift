//
//  TimerPickerView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import SwiftUI

struct TimerPickerViewModal: View {
    @State var timerPickerMode: TimerPickerMode
    @State var selectedHours: Int
    @State var selectedMinutes: Int
    @State var selectedSeconds: Int
    @State var presentationSetting: PresentationTimerSetting

    init(timerPickerMode: TimerPickerMode, presentationSetting: PresentationTimerSetting) {
        _timerPickerMode = State(initialValue: timerPickerMode)
        var settingTime = 0
        switch timerPickerMode {
        case .totalTime:
            settingTime = presentationSetting.totalTime
        case .first:
            settingTime = presentationSetting.firstSoundTime
        case .second:
            settingTime = presentationSetting.secondSoundTime
        case .third:
            settingTime = presentationSetting.thirdSoundTime
        }
        let time = TimeConverter.secondsToHoursMinutes(seconds: settingTime)
        _selectedHours =  State(initialValue: time.hour)
        _selectedMinutes = State(initialValue: time.minute)
        _selectedSeconds = State(initialValue: time.second)
        _presentationSetting = State(initialValue: presentationSetting)
    }
    var body: some View {
        VStack {
            Text("\(timerPickerMode.title)")
            HStack {
                Picker(selection: $selectedHours, label: Text("時間")) {
                    ForEach(0..<24) { hour in
                        Text("\(hour)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Text("時")
            }
            HStack {
                Picker(selection: $selectedMinutes, label: Text("分")) {
                    ForEach(0..<60) { minute in
                        Text("\(minute) ")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Text("分")
            }
            HStack {
                Picker(selection: $selectedSeconds, label: Text("秒")) {
                    ForEach(0..<60) { second in
                        Text("\(second)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Text("秒")
            }
            Button(action: {
                // タイマーの時間が選択された後の処理
                let totalSecond = selectedHours * 60 * 60 + selectedMinutes * 60 + selectedSeconds
                switch timerPickerMode {
                case .totalTime:
                    presentationSetting.totalTime = totalSecond
                case .first:
                    self.presentationSetting.firstSoundTime = totalSecond
                case .second:
                    self.presentationSetting.secondSoundTime = totalSecond
                case .third:
                    self.presentationSetting.thirdSoundTime = totalSecond
                }
            }, label: {
                Text("設定")
            })
        }
        .padding()
        .onAppear() {
        }
    }
}

struct TimerPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerPickerViewModal(timerPickerMode: .first, presentationSetting: PresentationTimerSetting(totalTime: 10, firstSoundTime: 10, secondSoundTime: 10, thirdSoundTime: 10, isFavorite: false, createdAt: Date()))
    }
}
