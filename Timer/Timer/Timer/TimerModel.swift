//
//  TimerModel.swift
//  Timer
//
//  Created by user on 04/11/24.
//

import Foundation

class TimerModel: ObservableObject {
    @Published var timeRemaining: Int = 60 // tempo em segundos
    var totalTime: Int = 60 // Defina o tempo máximo aqui
    private var timer: Timer?
    private let soundManager = SoundManager()

    var timeString: String {
        let hours = timeRemaining / 3600
        let minutes = (timeRemaining % 3600) / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    func setTime(time: Int) {
        self.totalTime = time
        self.timeRemaining = time
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                let randomSound = self.soundManager.getRandomSoundName()
                self.soundManager.playSound(named: randomSound) // Toca um som aleatório
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
}

