//
//  PresentationTimerSettingListView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import SwiftUI

struct PresentationTimerSettingListView: View {
    @AppStorage("PresentationSettingUUIDString") var specifiedPresentationSettingUUIDString = ""
    @Binding var selectedTab: Int
    @State private var showAlert = false
    let presentationTimerSettingRepository:PresentationTimerSettingRepository = PresentationTimerSettingRepository()
    @State private var settings: [PresentationTimerSetting] = []
    init(specifiedPresentationSettingUUIDString: String = "", selectedTab: Binding<Int>, showAlert: Bool = false) {
        self.specifiedPresentationSettingUUIDString = specifiedPresentationSettingUUIDString
        _selectedTab = selectedTab
        self.showAlert = showAlert
        _settings = State(initialValue: presentationTimerSettingRepository.loadAtCreated(ascending: true)
        )
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(settings, id: \.uuidString) { setting in
                    VStack(alignment: .leading) {
                        Text("プレゼン時間: \(converterTimerTextFromSecond(second:setting.totalTime) )")
                        Text("一回のベル時間: \(converterTimerTextFromSecond(second:setting.firstSoundTime) )")
                        Text("二回のベル時間: \(converterTimerTextFromSecond(second:setting.secondSoundTime) )")
                        Text("三回のベル時間: \(converterTimerTextFromSecond(second:setting.thirdSoundTime) )")
                        Text("お気に入り: \(setting.isFavorite ? "☆" : "")")
                    }
                    .onTapGesture {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("プレゼン時間の設定"),
                              message: Text("選択したプレゼン時間を設定しますか？"),
                              primaryButton: .default(Text("OK")){
                            selectedTab = 0
                            print(setting.uuidString)
                            specifiedPresentationSettingUUIDString = setting.uuidString
                        },
                              secondaryButton: .cancel(Text("キャンセル"))
                        )
                    }
                }
            }
            .navigationTitle("Settings")
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



struct PresentationTimerSettingListView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationTimerSettingListView(selectedTab: .constant(0))
    }
}

