//
//  VideoViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 10/3/15.
//  Copyright (c) 2015 Germano. All rights reserved.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Titles
        self.navigationItem.title = pointTitle
        self.snippetLabel.text = pointSnippet
        
        // Determining which video to stream
        if pointTitle == "CAVC"
        {
            embedLink = "<iframe src=\"https://player.vimeo.com/video/75529655?color=ffb310\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
        }
        else if pointTitle == "ECG"
        {
            embedLink = "<iframe src=\"https://player.vimeo.com/video/72423533\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
        }
        else if pointTitle == "ISTB1"
        {
            embedLink = "<iframe src=\"https://player.vimeo.com/video/76619593?color=ffb310\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
        }
        else if pointTitle == "ISTB4"
        {
            embedLink = "<iframe src=\"https://player.vimeo.com/video/69499459?color=ffb310\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
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
