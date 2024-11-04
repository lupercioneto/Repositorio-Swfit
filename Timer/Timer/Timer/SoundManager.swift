//
//  SoundManager.swift
//  Timer
//
//  Created by user on 04/11/24.
//

import AVFoundation

class SoundManager {
    var audioPlayer: AVAudioPlayer?
    var soundNames: [String] = []
    let defaultSoundName = "default_sound.mp3" // Nome do som padrão

    init() {
        loadSoundNames()
    }

    private func loadSoundNames() {
        let fileManager = FileManager.default
        let audioPath = Bundle.main.resourcePath! + "/Audios"

        do {
            let files = try fileManager.contentsOfDirectory(atPath: audioPath)
            soundNames = files.filter { $0.hasSuffix(".mp3") || $0.hasSuffix(".wav") } // Filtra apenas arquivos de áudio
        } catch {
            print("Error loading audio files: \(error.localizedDescription)")
        }
    }

    func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: "Audios/\(soundName)", withExtension: nil) else {
            // Toca o som padrão se o som não for encontrado
            playDefaultSound()
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
            // Toca o som padrão se ocorrer um erro
            playDefaultSound()
        }
    }

    func getRandomSoundName() -> String {
        return soundNames.randomElement() ?? defaultSoundName // Retorna um nome aleatório ou o padrão
    }

    private func playDefaultSound() {
        guard let url = Bundle.main.url(forResource: "Audios/\(defaultSoundName)", withExtension: nil) else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing default sound: \(error.localizedDescription)")
        }
    }
}

