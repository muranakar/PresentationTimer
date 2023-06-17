//
//  MainTabView.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            PresentationTimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("プレゼン")
                }
                .tag(0)

            PresentationTimerSettingListView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("リスト")
                }
                .tag(1)
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("設定")
                }
                .tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
