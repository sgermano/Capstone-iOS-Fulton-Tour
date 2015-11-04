//
//  InfoViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 11/3/15.
//  Copyright (c) 2015 Germano. All rights reserved.
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Label with directions to be aligned at the top-left
        infoLabel.sizeToFit()
        
        // Setting Titles and Image
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet
        self.imageView.image = pointImage

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
