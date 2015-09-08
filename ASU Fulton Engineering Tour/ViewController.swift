//
//  ViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Suzanne Germano on 4/19/15.
//  Copyright (c) 2015 Germano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //33° 25’ 12" N,111° 55’ 55" W 
 /*      
        var camera = GMSCameraPosition.cameraWithLatitude(33.419999999999995,
            longitude: -111.93194444444445, zoom: 6)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(33.419999999999995, -111.93194444444445)
        marker.title = "ECG"
        marker.snippet = "Arizona State University"
        marker.map = mapView
*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

