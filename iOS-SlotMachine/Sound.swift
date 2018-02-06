//
//  Sound.swift
//  iOS-SlotMachine
//
//  Created by Student on 2018-02-05.
//  Copyright © 2018 Rafael Matos. All rights reserved.
//

import Foundation
import AVFoundation

class Sound {
    
    var coinPlayer = AVAudioPlayer()
    
    var spinPlayer = AVAudioPlayer()
    var flyPlayer  = AVAudioPlayer()
    var shortPayOutPlayer = AVAudioPlayer()
    var richPayOutPlayer = AVAudioPlayer()
    var lostPlayer = AVAudioPlayer()
    
    public func Start() {
     
        spinPlayer = loadSound(filename: "itemreel", type: ".wav")
        flyPlayer  = loadSound(filename: "fly-1")
        shortPayOutPlayer = loadSound(filename: "short-payout")
        richPayOutPlayer = loadSound(filename: "rich-payout") //jackpot
        lostPlayer = loadSound(filename: "deep-gulp")
        coinPlayer = loadSound(filename: "insertingCoin")
    }
    
    public func loadSound( filename: String, type: String = ".mp3") -> AVAudioPlayer {
        let DIR = "Sounds/"
        var soundPlayer: AVAudioPlayer? = nil
        let sound = Bundle.main.path(forResource: DIR + filename, ofType: type)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound! ))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
        }catch{
            print(error)
        }
        soundPlayer?.prepareToPlay()
        return soundPlayer!
    }
}
