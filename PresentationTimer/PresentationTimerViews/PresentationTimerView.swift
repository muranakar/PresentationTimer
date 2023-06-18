//
//  ContentView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/15.
//
import SwiftUI
import AVFoundation

struct PresentationTimerView: View {
    @AppStorage("PresentationSettingUUIDString") var specifiedPresentationSettingUUIDString = ""
    @State private var presentationSetting: PresentationTimerSetting?
    private let presentationTimerSettingRepository:PresentationTimerSettingRepository = PresentationTimerSettingRepository()
    @State private var isShowingPicker = false
    @State private var timerPickerMode: TimerPickerMode = .first
    @StateObject private var timerManagerAndBellSound = TimerAndBellSound()

    init(specifiedPresentationSettingUUIDString: String = "", presentationSetting: PresentationTimerSetting? = nil, isShowingPicker: Bool = false, timerPickerMode: TimerPickerMode = .first, timerManagerAndBellSound: TimerAndBellSound = TimerAndBellSound()) {
        self.specifiedPresentationSettingUUIDString = specifiedPresentationSettingUUIDString
        self.presentationSetting = presentationSetting
        self.isShowingPicker = isShowingPicker
        self.timerPickerMode = timerPickerMode
        if specifiedPresentationSettingUUIDString == "" {
            let setting = PresentationTimerSetting(
                totalTime: 900, firstSoundTime: 600, secondSoundTime: 300, thirdSoundTime: 90, isFavorite: false
            )
            presentationTimerSettingRepository.append(
                presentationTimerSetting: setting
            )
            self.specifiedPresentationSettingUUIDString = setting.uuidString
        } else {
            self.presentationSetting = presentationTimerSettingRepository.load(uuidString: specifiedPresentationSettingUUIDString)
        }
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
                RemainTimerText(remainingTime: $timerManagerAndBellSound.remainingTime)
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height / 2
                    )
                    .onTapGesture {
                        isShowingPicker = true
                        timerPickerMode = .totalTime
                    }

                AllBellView(
                    firstTime:
                        presentationSetting?.firstSoundTime ?? 0,
                    secondTime:
                        presentationSetting?.secondSoundTime ?? 0,
                    thirdTime:
                        presentationSetting?.thirdSoundTime ?? 0,
                    firstButtonAction: {
                        isShowingPicker = true
                        timerPickerMode = .first
                    }, secondButtonAction: {
                        isShowingPicker = true
                        timerPickerMode = .second
                    }, thirdButtonAction: {
                        isShowingPicker = true
                        timerPickerMode = .third
                    })
                .frame(
                    width: geometry.size.width - 50 ,
                    height: geometry.size.height / 4
                )
                .sheet(isPresented: $isShowingPicker) {
                    TimerPickerViewModal(timerPickerMode: timerPickerMode,presentationSetting: presentationSetting!)

                }


                if timerManagerAndBellSound.timerMode == .initial {
                    HStack {
                        CustomButton(text: "Start") {
                            timerManagerAndBellSound.startTimer()
                        }
                    }
                } else if timerManagerAndBellSound.timerMode == .running {
                    HStack {
                        CustomButton(text: "Reset") {
                            timerManagerAndBellSound.resetTimer()
                        }
                        CustomButton(text: "Pause") {
                            timerManagerAndBellSound.pauseTimer()
                        }
                    }
                } else if timerManagerAndBellSound.timerMode == .pause {
                    HStack {
                        CustomButton(text: "Reset") {
                            timerManagerAndBellSound.resetTimer()
                        }
                        CustomButton(text: "resume") {
                            timerManagerAndBellSound.startTimer()
                        }
                    }
                } else if timerManagerAndBellSound.timerMode == .end {
                    HStack {
                        CustomButton(text: "Start") {
                            timerManagerAndBellSound.startTimer()
                        }
                    }
                }

                //                .alert(isPresented: $timerManagerAndBellSound.showAlert) {
                //                    Alert(title: Text("タイマー終了"), message: nil, dismissButton: .default(Text("OK")))
                //                }
            }
            .onChange(of: specifiedPresentationSettingUUIDString) { newValue in
                presentationSetting = presentationTimerSettingRepository.load(uuidString: specifiedPresentationSettingUUIDString)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationTimerView()
    }
}

