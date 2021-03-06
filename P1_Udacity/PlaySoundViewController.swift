//
//  PlaySoundViewController.swift
//  P1_Udacity
//
//  Created by KimCP on 2015. 5. 12..
//  Copyright (c) 2015년 beehive. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
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
        allSoundStop()
        changeSoundRate(0.5)
    }

    @IBAction func playFastSound(sender: UIButton) {
        allSoundStop()
        changeSoundRate(1.5)
    }
    
    func changeSoundRate(rate: Float){
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
        
    @IBAction func chipmunkPlay(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthvaderPlay(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        allSoundStop()
        
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
    
    @IBAction func stopSound(sender: UIButton) {
        allSoundStop()
    }
    
    func allSoundStop(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
