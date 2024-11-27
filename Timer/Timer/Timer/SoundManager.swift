import AVFoundation

class SoundManager: NSObject {  // Herança de NSObject
    var audioPlayer: AVAudioPlayer?
    var soundNames: [String] = []
    let defaultSoundName = "default_sound.mp3" // Nome do som padrão

    override init() {
        super.init()
        loadSoundNames()
    }

    private func loadSoundNames() {
        guard let audioPath = Bundle.main.path(forResource: "Audios", ofType: "") else {
            print("Error loading audio path.")
            return
        }

        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: audioPath)
            soundNames = files.filter { $0.hasSuffix(".mp3") || $0.hasSuffix(".wav") }
        } catch {
            print("Error loading audio files: \(error.localizedDescription)")
        }
    }

    func playSound(named soundName: String) {
        // Ver se já existe um player tocando 
        if let player = audioPlayer, player.isPlaying {
            player.stop() 
        }
        
        // Busca o URL do arquivo de áudio
        guard let url = Bundle.main.url(forResource: soundName, withExtension: nil, subdirectory: "Audios") else {
            print("Audio file not found, playing default sound.")
            playDefaultSound()  // Toca o som padrão em caso de erro
            return
        }

        do {
            // Inicializa o player de áudio
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self  // delegate pra responder a eventos
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
            playDefaultSound()  // Toca o som padrão em caso de erro
        }
    }

    func getRandomSoundName() -> String {
        return soundNames.randomElement() ?? defaultSoundName
    }

    private func playDefaultSound() {
        guard let url = Bundle.main.url(forResource: defaultSoundName, withExtension: nil, subdirectory: "Audios") else {
            print("Default sound not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing default sound: \(error.localizedDescription)")
        }
    }
}

extension SoundManager: AVAudioPlayerDelegate {
    // Reset do player após a reprodução do áudio
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer = nil
    }
}
