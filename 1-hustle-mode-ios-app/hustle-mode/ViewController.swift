//
//  ViewController.swift
//  hustle-mode
//
//  Created by milkbag on 2018-11-10.
//  Copyright © 2018 milkbag. All rights reserved.
//

import UIKit
import AVFoundation // Allows us to play audio

class ViewController: UIViewController {
    
    // Grabbed from the side by holding Ctrl and dragging into the code

    @IBOutlet weak var darkBlueBG: UIImageView!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var hustleLbl: UILabel!
    @IBOutlet weak var onLbl: UILabel!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grabbing audio file
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        // Pass in path that we just created ^ (path was a String, now we're converting it to a URL)
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }

    @IBAction func powerBtnPressed(_ sender: Any) {
        cloudHolder.isHidden = false
        darkBlueBG.isHidden = true
        powerButton.isHidden = true
        
        player.play()
        
        UIView.animate(withDuration: 2.3, animations: {
            // Over 2.3 seconds, move the rocket x,y position and keep the original width and height
            self.rocket.frame = CGRect(x: 0, y: 140, width: 399, height: 435)
        }) { (finished) in
            self.hustleLbl.isHidden = false
            self.onLbl.isHidden = false
        }
    }
    
}

