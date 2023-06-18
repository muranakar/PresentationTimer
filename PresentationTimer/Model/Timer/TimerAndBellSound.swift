//
//  TimerManager.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import Foundation
import AVFAudio

class TimerAndBellSound: ObservableObject {
    enum TimerMode {
        case initial
        case running
        case pause
        case end
    }
    let initialTime: Int = 900
    @Published var remainingTime = 900
    @Published var isTimerRunning = false
    @Published var timerMode: TimerMode = .initial
    @Published var showAlert = false

    @Published  var firstBellTime = 8
    @Published  var secondBellTime = 5
    @Published  var thirdBellTime = 3


    private var audioPlayer: AVAudioPlayer?

    private var timer: Timer?

    // タイマーの更新とアラート表示の管理を行う関数
    func updateTimerAndPlayBell() {
        remainingTime -= 1
        if remainingTime == firstBellTime {
            playBell() // 残り10分でベルを鳴らす
        } else if remainingTime == secondBellTime {
            playBell() // 残り5分でベルを鳴らす
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.playBell()
            }
        } else if remainingTime == thirdBellTime {
            playBell() // 残り3分でベルを鳴らす
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.playBell()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.playBell()
            }
        }

        if remainingTime == 0 {
            showAlert = true // タイマー終了時にアラートを表示
            timerMode = .end
        }
    }

    // タイマーを開始する関数
    func startTimer() {

            timerMode = .running
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.updateTimerAndPlayBell()
            }

    }

    // タイマーを停止する関数
    func resetTimer() {
        remainingTime = initialTime
        timerMode = .initial
            timer?.invalidate()
            timer = nil

    }

    // タイマーを一時停止する関数
    func pauseTimer() {
        timerMode = .pause
            timer?.invalidate()
            timer = nil
    }

    // ベルの再生を行う関数
    func playBell() {
        guard let soundURL = Bundle.main.url(forResource: "bell", withExtension: "mp3") else {
            print("音声ファイルが見つかりません")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {

        }
    }
}
