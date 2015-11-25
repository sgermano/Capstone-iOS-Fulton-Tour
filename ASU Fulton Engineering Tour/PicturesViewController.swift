//
//  PicturesViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 10/4/15.
//  Copyright (c) 2015 Tour Devil. All rights reserved.
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
    
    // Variable to Parse XML
    var parser: TourXMLParser = TourXMLParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parsing XML
        parser.beginParsing()
        
        // Setting Titles
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet
        
        // Determining which pictures to display
        if pointTitle == "Bookstore"
        {
            for (var i = 0; i < parser.imagesBookstore.count; i++)
            {
                if let url  = NSURL(string: parser.imagesBookstore[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "ECF"
        {
            for (var i = 0; i < parser.imagesECF.count; i++)
            {
                if let url  = NSURL(string: parser.imagesECF[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "ECG"
        {
            for (var i = 0; i < parser.imagesECG.count; i++)
            {
                if let url  = NSURL(string: parser.imagesECG[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "ERC"
        {
            for (var i = 0; i < parser.imagesERC.count; i++)
            {
                if let url  = NSURL(string: parser.imagesERC[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "ISTB1"
        {
            for (var i = 0; i < parser.imagesISTB1.count; i++)
            {
                if let url  = NSURL(string: parser.imagesISTB1[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "Math Center"
        {
            for (var i = 0; i < parser.imagesMathCenter.count; i++)
            {
                if let url  = NSURL(string: parser.imagesMathCenter[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "NOBLE"
        {
            for (var i = 0; i < parser.imagesNOBLE.count; i++)
            {
                if let url  = NSURL(string: parser.imagesNOBLE[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
            imageView.image = images[index]
        }
        else if pointTitle == "PSA"
        {
            for (var i = 0; i < parser.imagesPSA.count; i++)
            {
                if let url  = NSURL(string: parser.imagesPSA[i]), data = NSData(contentsOfURL: url)
                {
                    images.append(UIImage(data: data)!)
                }
            }
            
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
