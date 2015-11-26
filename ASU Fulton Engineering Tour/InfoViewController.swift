//
//  InfoViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 11/3/15.
//  Copyright (c) 2015 Tour Devil. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    // Variables used to receive info from smTourMapViewController
    var pointTitle: String = String()
    var pointSnippet: String = String()
    var pointImage: UIImage = UIImage()
    var pointIndex: Int = Int()
    var numPoints: Int = Int()
    
    // Variable to Parse XML
    var parser: TourXMLParser = TourXMLParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parsing XML
        parser.beginParsing()
        
        // Setting Label with directions to be aligned at the top-left
        infoLabel.sizeToFit()
        
        // Setting Titles and Image
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet
        self.imageView.image = pointImage
        
        // Setting infoLabel to correct Building Description
        if pointTitle == "ECG"
        {
            // Trims extra whitespace and newlines
            let trimmedDescript = parser.descriptionECG.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "ECF"
        {
            let trimmedDescript = parser.descriptionECF.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "PSA"
        {
            let trimmedDescript = parser.descriptionPSA.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "Math Center"
        {
            let trimmedDescript = parser.descriptionMathCenter.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "ERC"
        {
            let trimmedDescript = parser.descriptionERC.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "NOBLE"
        {
            let trimmedDescript = parser.descriptionNOBLE.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "ISTB1"
        {
            let trimmedDescript = parser.descriptionISTB1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }
        else if pointTitle == "Bookstore"
        {
            let trimmedDescript = parser.descriptionBookstore.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            infoLabel.text = trimmedDescript
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sending current Tour Point info to Video or Pictures View Controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toVideo"
        {
            if let videoViewController: VideoViewController = segue.destinationViewController as? VideoViewController {
                videoViewController.pointTitle = pointTitle
                videoViewController.pointSnippet = pointSnippet
            }
        }
        else if segue.identifier == "toPictures"
        {
            if let picturesViewController: PicturesViewController = segue.destinationViewController as? PicturesViewController {
                picturesViewController.pointTitle = pointTitle
                picturesViewController.pointSnippet = pointSnippet
            }
        }
        else if segue.identifier == "toAudio"
        {
            if let audioViewController: AudioViewController = segue.destinationViewController as? AudioViewController {
                audioViewController.pointTitle = pointTitle
                audioViewController.pointSnippet = pointSnippet
            }
        }
    }
    
    // Action to Resume Tour
    @IBAction func resumeTour(sender: UIButton) {
        
        if pointIndex == numPoints - 1
        {
            let finalView: FinalViewController = storyboard?.instantiateViewControllerWithIdentifier("finalViewController") as! FinalViewController
            
            presentViewController(finalView, animated: true, completion: nil)
        }
        else
        {
            navigationController!.popViewControllerAnimated(true)
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
