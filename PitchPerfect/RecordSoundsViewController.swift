//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Vidya Durvasula on 8/9/17.
//  Copyright © 2017 Vidya Durvasula. All rights reserved.
//

import UIKit
import AVFoundation
class  RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var stoprecordingbutton: UIButton!
    
    @IBOutlet weak var recordingbutton: UIButton!
    @IBOutlet var recordinglabel: UILabel!
    
    func switchLabelsAndButtons(isRecording: Bool) {
        
        recordinglabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recordingbutton.isEnabled = !isRecording
        stoprecordingbutton.isEnabled = isRecording
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stoprecordingbutton.isEnabled = false
        self.navigationItem.hidesBackButton = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func record(_ sender: Any) {
        switchLabelsAndButtons(isRecording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate=self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        if audioRecorder.isRecording{
            print("recording")
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func stoprecording(_ sender: Any) {
        switchLabelsAndButtons(isRecording: false)
        audioRecorder.stop()
        if audioRecorder.isRecording{
            print("still recording")
        }
        let audiosession = AVAudioSession.sharedInstance()
        try! audiosession.setActive(false)
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stoprecording", sender: audioRecorder.url)
            self.navigationItem.hidesBackButton = false
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "recording not finished", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            })
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                print("OK")
            })
            
            present(alert, animated: true)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stoprecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
    
    
}





