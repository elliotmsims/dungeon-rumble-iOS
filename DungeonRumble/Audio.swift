//
//  Audio.swift
//  DungeonRumble
//
//  Created by Anthony Modica on 10/14/22.
//

import Foundation
import AVFoundation
var gameAudio: AVAudioPlayer?
public var musicSystem = Audio()

public class Audio {
    
    // TODO: add more tracks
    let trackNames: [String] = ["TalesOfOld", "Birdsong", "OtherSideOfTheMoon"]
    var currentTrackIndex = 0
    
    func playAudio(fileName: String = "TalesOfOld") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("failed to retrieve audio url")
            return
        }
        
        do {
            gameAudio = try AVAudioPlayer(contentsOf: url)
            gameAudio?.numberOfLoops = -1 // plays continuously
            gameAudio?.prepareToPlay()
            gameAudio?.play()
        } catch {
            print("failed to load audio file")
        }
    }
    
    func changeTrack() {
        currentTrackIndex += 1
        playAudio(fileName: trackNames[currentTrackIndex % trackNames.count])
    }
    
    func stopAudio() {
        currentTrackIndex = 0
        gameAudio?.stop()
    }
    
}
