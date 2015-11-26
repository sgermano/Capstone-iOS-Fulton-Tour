//
//  AudioViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 11/26/15.
//  Copyright (c) 2015 Germano. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    @IBOutlet weak var snippetLabel: UILabel!
    
    // Used to play the Audio file located in the server
    var player = AVPlayer()
    
    // Variables used to receive info from smTourMapViewController
    var pointTitle: String = String()
    var pointSnippet: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Titles
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action to Play Audio
    @IBAction func playAudio(sender: UIButton) {
        
        let url = "http://tourdevil.fulton.asu.edu/resources/music.mp3"
        let playerItem = AVPlayerItem( URL:NSURL( string:url ) )
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
