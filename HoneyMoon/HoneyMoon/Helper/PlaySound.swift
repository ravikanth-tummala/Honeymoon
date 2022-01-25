//
//  PlaySound.swift
//  HoneyMoon
//
//  Created by GeoSpark on 25/01/22.
//

import AVFoundation

var audioPlayer:AVAudioPlayer?

func playSound(sound:String,type:String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch {
            print("Errro: Could not find and plat the sound file!")
        }
    }
}
