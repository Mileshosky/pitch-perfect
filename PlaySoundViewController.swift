//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Britt Mileshosky on 5/11/15.
//  Copyright (c) 2015 Britt Mileshosky. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
        playAudio(playRate: 0.5)
    }
    
    @IBAction func playSoundFast(sender: UIButton) {
        playAudio(playRate: 2.0)
    }
    
    @IBAction func stopAllSounds(sender: UIButton) {
        stopAudio()
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        self.playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthSound(sender: UIButton) {
        self.playAudioWithVariablePitch(-1000)
    }
    
    func stopAudio(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudio(playRate:Float = 1.0) {
        stopAudio()
        audioPlayer.rate = playRate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudio() // Best practice is to stop our audio player.
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
