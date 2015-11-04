//
//  PicturesViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 10/4/15.
//  Copyright (c) 2015 Germano. All rights reserved.
//

import UIKit

class PicturesViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var snippetLabel: UILabel!
    
    // Variables used to hold images and keep track of index
    var images: [UIImage] = []
    var index: Int = 0
    
    // Variables used to receive info from smTourMapViewController
    var pointTitle: String = String()
    var pointSnippet: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Titles
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet
        
        // Determining which pictures to display
        if pointTitle == "BYENG"
        {
            images.append(UIImage(named: "BYENG.jpg")!)
            images.append(UIImage(named: "BYAC.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "CAVC"
        {
            images.append(UIImage(named: "CAVC.jpg")!)
            images.append(UIImage(named: "CAVC-2.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "CTRPT"
        {
            images.append(UIImage(named: "CTRPT.jpg")!)
            images.append(UIImage(named: "CTRPT-2.jpg")!)
            images.append(UIImage(named: "CTRPT-3.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "ECF"
        {
            images.append(UIImage(named: "ECF.jpg")!)
            images.append(UIImage(named: "ECF-2.jpg")!)
            images.append(UIImage(named: "ECF-3.jpg")!)
            images.append(UIImage(named: "ECF-4.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "ECG"
        {
            images.append(UIImage(named: "ECG.jpg")!)
            images.append(UIImage(named: "ECG-2.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "ERC"
        {
            images.append(UIImage(named: "ERC.jpg")!)
            images.append(UIImage(named: "ERC-2.jpg")!)
            images.append(UIImage(named: "ERC-3.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "ISTB1"
        {
            images.append(UIImage(named: "ISTB1.jpg")!)
            images.append(UIImage(named: "ISTB1-2.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "ISTB4"
        {
            images.append(UIImage(named: "ISTB4.jpg")!)
            images.append(UIImage(named: "ISTB4-2.jpg")!)
            images.append(UIImage(named: "ISTB4-3.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "Math Center"
        {
            images.append(UIImage(named: "Math Center.jpg")!)
            images.append(UIImage(named: "Math Center-2.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "NOBLE"
        {
            images.append(UIImage(named: "NOBLE.jpg")!)
            images.append(UIImage(named: "NOBLE-2.jpg")!)
            images.append(UIImage(named: "NOBLE-3.jpg")!)
            imageView.image = images[index]
        }
        else if pointTitle == "Palm Walk"
        {
            images.append(UIImage(named: "Palm Walk.jpg")!)
            images.append(UIImage(named: "Palm Walk-2.jpg")!)
            images.append(UIImage(named: "Palm Walk-3.png")!)
            imageView.image = images[index]
        }
        else if pointTitle == "PSA"
        {
            images.append(UIImage(named: "PSA.jpg")!)
            images.append(UIImage(named: "PSA-2.jpg")!)
            imageView.image = images[index]
        }
        else
        {
            images.append(UIImage(named: "ASU-fork-2.png")!)
            imageView.image = images[index]
            self.snippetLabel.text = "Sorry there are no pictures to display"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action for when the "Next" Button is pressed
    @IBAction func nextPressed(sender: UIButton) {
        
        // If at head of array list, go to tail
        if index == images.count - 1
        {
            index = 0
            imageView.image = images[index]
        }
        else // Else go to next index in images array list
        {
            index++
            imageView.image = images[index]
        }
    }

    // Action for when the "Previous" Button is pressed
    @IBAction func prevPressed(sender: UIButton) {
        
        // If at tail of array list, go to head
        if index == 0
        {
            index = images.count - 1
            imageView.image = images[index]
        }
        else // Else go to previous index in images array list
        {
            index--
            imageView.image = images[index]
        }
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
