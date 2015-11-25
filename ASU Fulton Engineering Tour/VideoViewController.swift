//
//  VideoViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 10/3/15.
//  Copyright (c) 2015 Tour Devil. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var snippetLabel: UILabel!
    
    // Variables used to receive info from smTourMapViewController
    var pointTitle: String = String()
    var pointSnippet: String = String()
    
    // Variables for the embedded link to a video
    var embedLink: NSString = NSString()
    
    // Variable to Parse XML
    var parser: TourXMLParser = TourXMLParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parsing XML
        parser.beginParsing()
        
        // Setting Titles
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet
        
        // Determining which video to stream
        if pointTitle == "ECG"
        {
            embedLink = parser.videosECG[0]
        }
        else if pointTitle == "ECF"
        {
            embedLink = parser.videosECF[0]
        }
        else if pointTitle == "PSA"
        {
            embedLink = parser.videosPSA[0]
        }
        else if pointTitle == "Math Center"
        {
            embedLink = parser.videosMathCenter[0]
        }
        else if pointTitle == "ERC"
        {
            embedLink = parser.videosERC[0]
        }
        else if pointTitle == "NOBLE"
        {
            embedLink = parser.videosNOBLE[0]
        }
        else if pointTitle == "ISTB1"
        {
            embedLink = parser.videosISTB1[0]
        }
        else if pointTitle == "Bookstore"
        {
            embedLink = parser.videosBookstore[0]
        }
        else // Else show a Fulton Engineering Video
        {
            embedLink = "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/7rzNkG9u3U8\" frameborder=\"0\" allowfullscreen></iframe>"
        }
        
        /*// Setting a frame for WebView (Doesn't seem to work)
        self.webView.frame = CGRect(x: 15, y: 150, width: self.webView.frame.size.width, height: self.webView.frame.size.height)*/
        
        // Loading video to WebView
        self.webView.loadHTMLString(embedLink as String, baseURL: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
