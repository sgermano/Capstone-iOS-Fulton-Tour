//
//  FinalViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 11/24/15.
//  Copyright (c) 2015 Germano. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartTour(sender: UIButton) {
        
        let firstView: UINavigationController = storyboard?.instantiateViewControllerWithIdentifier("firstNavView") as! UINavigationController
        
        presentViewController(firstView, animated: true, completion: nil)
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
