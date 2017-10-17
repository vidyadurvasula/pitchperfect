//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Vidya Durvasula on 8/9/17.
//  Copyright © 2017 Vidya Durvasula. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var recordedAudioURL : URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case snail = 0, fast, highpitch, lowpitch, echo, reverb
    }
    
    
    @IBOutlet weak var snail: UIButton!
    
    @IBOutlet weak var fast: UIButton!
    
    @IBOutlet weak var echo: UIButton!
    @IBOutlet weak var reverb: UIButton!
    
    @IBOutlet weak var highpitch: UIButton!
    @IBOutlet weak var lowpitch: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func stopButtonPressed(_sender: AnyObject){
        stopAudio()
        
    }
    @IBAction func PlaySoundbutton(_sender: AnyObject){
        switch(ButtonType(rawValue: _sender.tag)!) {
        case .snail:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highpitch:
            playSound(pitch: 1000)
        case .lowpitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        
        }
        
        configureUI(.playing)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        snail.imageView?.contentMode = .scaleAspectFit
        fast.imageView?.contentMode = .scaleAspectFit
        highpitch.imageView?.contentMode = .scaleAspectFit
        lowpitch.imageView?.contentMode = .scaleAspectFit
        echo.imageView?.contentMode = .scaleAspectFit
        reverb.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
        
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
   
}
