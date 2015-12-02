
//
//  smTourMapViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Suzanne Germano on 4/22/15.
//  Copyright (c) 2015 Tour Devil. All rights reserved.
//

import UIKit
import Foundation

class smTourMapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    struct tourPoint {
        var id: Int
        var pointLatitude: Double
        var pointLongitude: Double
        var title: String
        var snippet: String
    }
    
    var currentTourPoint : tourPoint!
    var tourPoints = [tourPoint] ()
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    var gmsMarkers = [GMSMarker] ()
    
    var destLatitude : Double = 0.0
    var destLongitude : Double = 0.0
    var startLatitude : Double = 0.0
    var startLongitude : Double = 0.0
    var currentPoint : Int = 0
    var nextPoint : Int = 1
    
    @IBOutlet weak var imgBuilding: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var viewInfoButton: UIButton!
    
    // Variable to Parse XML
    var parser: TourXMLParser = TourXMLParser()
    
    // Variables for directions
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    // Stores first route
    var selectedRoute: Dictionary<NSObject, AnyObject>!
    // hold the overview polyline dictionary
    var overviewPolyline: Dictionary<NSObject, AnyObject>!
    //longitude and latitude of the origin and the destination locations respectively
    var originCoordinate: CLLocationCoordinate2D!
    var destinationCoordinate: CLLocationCoordinate2D!
    //hold the origin and destination addresses as string values and as they’re contained in the APIs response
    var originAddress: String!
    var destinationAddress: String!
    var originMarker: GMSMarker!
    
    var destinationMarker: GMSMarker!
    
    var routePolyline: GMSPolyline!
    var totalDistanceInMeters: UInt = 0
    
    var totalDistance: String!
    
    var totalDurationInSeconds: UInt = 0
    
    var totalDuration: String!
    
    var justBegan: Bool = true
    
    @IBOutlet weak var mySmallMapView: GMSMapView!
    
    
    // Load the tour points from JSON document
    func loadPoints(){
        var i = 0; // loop counter
        
        let path = NSBundle.mainBundle().pathForResource("ASUTourPoints", ofType: "json")
        
        
       let jsonData = NSData(contentsOfFile:path!)

        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary)
        var points : NSArray = jsonResult["waypoint"] as! NSArray
        for item in points{
            var myTitle = points[i]["title"] as! String
            var mySnippet = points[i]["snippet"] as! String
            var myLat = points[i]["lat"] as! String
            var myLong = points[i]["long"] as! String
            var myID = points[i]["id"] as! String
            
            currentTourPoint = tourPoint(id: myID.toInt()!, pointLatitude: (myLat as NSString).doubleValue, pointLongitude: (myLong as NSString).doubleValue, title: myTitle, snippet: mySnippet)
            tourPoints.append(currentTourPoint)
            
            i++
        }
        
        // Hide Labels and "View Info" Button
        self.lblText.hidden = true
        self.directionsLabel.hidden = true
        self.viewInfoButton.hidden = true
    }
    
    
    func nextTourPoint(sender: UIBarButtonItem){
        /*
        
        mySmallMapView.clear()
        var latCenter = (tourPoints[currentPoint].pointLatitude + tourPoints[nextPoint].pointLatitude) / 2
        var longCenter = (tourPoints[currentPoint].pointLongitude + tourPoints[nextPoint].pointLongitude) / 2
        var camera = GMSCameraPosition.cameraWithLatitude(latCenter,
            longitude: longCenter, zoom: 18 )
        var markerCurrent = GMSMarker()
        markerCurrent.position = CLLocationCoordinate2DMake(tourPoints[currentPoint].pointLatitude, tourPoints[currentPoint].pointLongitude)
        markerCurrent.appearAnimation = kGMSMarkerAnimationPop
        markerCurrent.title = tourPoints[currentPoint].title
        markerCurrent.snippet = tourPoints[currentPoint].snippet
        markerCurrent.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        markerCurrent.map = mySmallMapView
        gmsMarkers.append(markerCurrent)
        
        var markerNext = GMSMarker()
        markerNext.position = CLLocationCoordinate2DMake(tourPoints[nextPoint].pointLatitude, tourPoints[nextPoint].pointLongitude)
        markerNext.appearAnimation = kGMSMarkerAnimationPop
        markerNext.title = tourPoints[nextPoint].title
        markerNext.snippet = tourPoints[nextPoint].snippet
        markerNext.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        markerNext.map = mySmallMapView
        gmsMarkers.append(markerNext)
        */
        
        // Making sure the tour starts at ECG
        if justBegan == true
        {
            currentPoint = 0
            nextPoint = 0
        }
        
        let originCoordinate = (NSString(format: "%.15f", tourPoints[currentPoint].pointLatitude) as String) + "," + (NSString(format: "%.15f", tourPoints[currentPoint].pointLongitude) as String)
        
        let destinationCoordinate = (NSString(format: "%.15f", tourPoints[nextPoint].pointLatitude) as String) + "," + (NSString(format: "%.15f", tourPoints[nextPoint].pointLongitude) as String)
        var waypointsArray: Array<String> = []
        let myLatitude = tourPoints[nextPoint].pointLatitude
        let myLongitude = tourPoints[nextPoint].pointLongitude
        let coord = CLLocationCoordinate2D(latitude: myLatitude as
            CLLocationDegrees, longitude: myLongitude as CLLocationDegrees)
        getDirections(originCoordinate, destination : destinationCoordinate, waypoints : nil, travelMode : "walking", completionHandler: { (status, success) -> Void in
            if success {
                self.configureMapAndMarkersForRoute()
                self.drawRoute()
                self.displayRouteInfo()
                self.drawCircle(coord)
            }
            else {
                println(status)
            }
        })

        
        //self.mySmallMapView.camera = camera
        
        // Show Labels and "View Info" Button
        self.lblText.hidden = false
        self.directionsLabel.hidden = false
        self.viewInfoButton.hidden = false
    }
    
    func configureMapAndMarkersForRoute(){
        mySmallMapView.clear()
        var latCenter = (tourPoints[currentPoint].pointLatitude + tourPoints[nextPoint].pointLatitude) / 2
        var longCenter = (tourPoints[currentPoint].pointLongitude + tourPoints[nextPoint].pointLongitude) / 2
        var camera = GMSCameraPosition.cameraWithLatitude(latCenter,
            longitude: longCenter, zoom: 18 )
        var markerCurrent = GMSMarker()
        markerCurrent.position = CLLocationCoordinate2DMake(tourPoints[currentPoint].pointLatitude, tourPoints[currentPoint].pointLongitude)
        markerCurrent.appearAnimation = kGMSMarkerAnimationPop
        markerCurrent.title = tourPoints[currentPoint].title
        markerCurrent.snippet = tourPoints[currentPoint].snippet
        markerCurrent.icon = UIImage(named: "ASU-fork-2")
        //markerCurrent.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        markerCurrent.map = mySmallMapView
        gmsMarkers.append(markerCurrent)
        
        var markerNext = GMSMarker()
        markerNext.position = CLLocationCoordinate2DMake(tourPoints[nextPoint].pointLatitude, tourPoints[nextPoint].pointLongitude)
        markerNext.appearAnimation = kGMSMarkerAnimationPop
        markerNext.title = tourPoints[nextPoint].title
        markerNext.snippet = tourPoints[nextPoint].snippet
        markerNext.icon = UIImage(named: "ASU-fork-1")
        //markerNext.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        markerNext.map = mySmallMapView
        gmsMarkers.append(markerNext)
        
        if justBegan == true
        {
            let destImage = markerCurrent.title + ".jpg"
            imgBuilding.image =  UIImage(named: destImage)
            lblText.text = markerCurrent.snippet
            self.mySmallMapView.camera = camera
            
            // Trims extra whitespace and newlines
            let trimmedDirections = parser.directionsECG.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            directionsLabel.text = trimmedDirections
        }
        else
        {
            let destImage = markerNext.title + ".jpg"
            imgBuilding.image =  UIImage(named: destImage)
            lblText.text = markerNext.snippet
            self.mySmallMapView.camera = camera
            
            // Setting directionsLabel to correct Directions to next Building
            if markerNext.title == "ECG"
            {
                let trimmedDirections = parser.directionsECG.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "ECF"
            {
                let trimmedDirections = parser.directionsECF.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "PSA"
            {
                let trimmedDirections = parser.directionsPSA.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "Math Center"
            {
                let trimmedDirections = parser.directionsMathCenter.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "ERC"
            {
                let trimmedDirections = parser.directionsERC.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "NOBLE"
            {
                let trimmedDirections = parser.directionsNOBLE.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "ISTB1"
            {
                let trimmedDirections = parser.directionsISTB1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
            else if markerNext.title == "Bookstore"
            {
                let trimmedDirections = parser.directionsBookstore.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                directionsLabel.text = trimmedDirections
            }
        }
        
        if (currentPoint == tourPoints.count-1){
           currentPoint = 0
            
            let finalView: FinalViewController = storyboard?.instantiateViewControllerWithIdentifier("finalViewController") as! FinalViewController
            
            presentViewController(finalView, animated: true, completion: nil)
        }
        else{
            currentPoint++
        }
    
        if (nextPoint == tourPoints.count-1){
            nextPoint = 0}
        else{
            nextPoint++}
        
        if justBegan == true
        {
            currentPoint = 0
            nextPoint = 1
            justBegan = false
        }
    }
    
    func drawRoute(){
        let route = overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)
        routePolyline = GMSPolyline(path: path)
        routePolyline.map = mySmallMapView
        routePolyline.strokeWidth = 5
        routePolyline.strokeColor = UIColor.blackColor()
    }
    
    func drawCircle(position: CLLocationCoordinate2D) {
        
        //var latitude = position.latitude
        //var longitude = position.longitude
        //var circleCenter = CLLocationCoordinate2DMake(latitude, longitude)
        var circle = GMSCircle(position: position, radius: 20)
        circle.strokeColor = UIColor.blueColor()
        circle.fillColor = UIColor(red: 0, green: 0, blue: 0.35, alpha: 0.20)
        circle.map = mySmallMapView
        
    }
    
    func displayRouteInfo(){
        //lblText.text = totalDistance + "\n" + totalDuration
    }
    
    func calculateTotalDistanceAndDuration() {
        let legs = self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>>
        
        totalDistanceInMeters = 0
        totalDurationInSeconds = 0
        
        for leg in legs {
            totalDistanceInMeters += (leg["distance"] as! Dictionary<NSObject, AnyObject>)["value"] as! UInt
            totalDurationInSeconds += (leg["duration"] as! Dictionary<NSObject, AnyObject>)["value"] as! UInt
        }
        
        
        let distanceInKilometers: Double = Double(totalDistanceInMeters / 1000)
        totalDistance = "Total Distance: \(distanceInKilometers) Km"
        
        
        let mins = totalDurationInSeconds / 60
        let hours = mins / 60
        let days = hours / 24
        let remainingHours = hours % 24
        let remainingMins = mins % 60
        let remainingSecs = totalDurationInSeconds % 60
        
        totalDuration = "Duration: \(days) d, \(remainingHours) h, \(remainingMins) mins, \(remainingSecs) secs"
    }
    
    func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: ((status: String, success: Bool) -> Void)) {
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation + "&mode=walking"
                
                directionsURLString = directionsURLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                
                let directionsURL = NSURL(string: directionsURLString)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let directionsData = NSData(contentsOfURL: directionsURL!)
                    
                    var error: NSError?
                    let dictionary: Dictionary<NSObject, AnyObject> = NSJSONSerialization.JSONObjectWithData(directionsData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! Dictionary<NSObject, AnyObject>
                    
                    if (error != nil) {
                        println(error)
                        completionHandler(status: "", success: false)
                    }
                    else {
                        let status = dictionary["status"] as! String
                        
                        if status == "OK" {
                            self.selectedRoute = (dictionary["routes"] as! Array<Dictionary<NSObject, AnyObject>>)[0]
                            self.overviewPolyline = self.selectedRoute["overview_polyline"] as! Dictionary<NSObject, AnyObject>
                            
                            let legs = self.selectedRoute["legs"] as! Array<Dictionary<NSObject, AnyObject>>
                            
                            let startLocationDictionary = legs[0]["start_location"] as! Dictionary<NSObject, AnyObject>
                            self.originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat"] as! Double, startLocationDictionary["lng"] as! Double)
                            
                            let endLocationDictionary = legs[legs.count - 1]["end_location"] as! Dictionary<NSObject, AnyObject>
                            self.destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat"] as! Double, endLocationDictionary["lng"] as! Double)
                            
                            self.originAddress = legs[0]["start_address"] as! String
                            self.destinationAddress = legs[legs.count - 1]["end_address"] as! String
                            
                            self.calculateTotalDistanceAndDuration()
                            
                            completionHandler(status: status, success: true)
                        }
                        else {
                            completionHandler(status: status, success: false)
                        }
                    }
                })
            }
            else {
                completionHandler(status: "Destination is nil.", success: false)
            }
        }
        else {
            completionHandler(status: "Origin is nil", success: false)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPoints()
        
        // Parsing XML
        parser.beginParsing()
        
        // Setting Label with directions to be aligned at the top-left
        directionsLabel.sizeToFit()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next Tour Point",
            style: .Plain,
            target: self,
            action: "nextTourPoint:"
            
        )
        currentPoint = 0
        // start new code
        mySmallMapView.accessibilityElementsHidden = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //locationManager.distanceFilter = 5
        locationManager.requestWhenInUseAuthorization()
        mySmallMapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        // end new code
        // Do any additional setup after loading the view.
        var camera = GMSCameraPosition.cameraWithLatitude(33.419999999999995,
            longitude: -111.93194444444445, zoom: 15 )
        
        //
        //mySmallMapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        //mySmallMapView.camera = camera
        mySmallMapView.myLocationEnabled = true
        self.mySmallMapView.camera = camera
        //self.view = mySmallMapView
        
        // Markers to show all tour points on first screen after "START TOUR" Button pressed
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(33.419999999999995, -111.93194444444445)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.title = "ECG"
        marker.snippet = "Engineering Center G"
        marker.icon = UIImage(named: "ASU-fork-2")
        marker.map = mySmallMapView
        gmsMarkers.append(marker)
        
        var marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2DMake(33.419710, -111.932590)
        marker2.appearAnimation = kGMSMarkerAnimationPop
        marker2.title = "ECF"
        marker2.snippet = "Engineering Tutoring Center"
        marker2.icon = UIImage(named: "ASU-fork-2")
        marker2.map = mySmallMapView
        gmsMarkers.append(marker2)
        
        var marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2DMake(33.420298, -111.932593)
        marker3.appearAnimation = kGMSMarkerAnimationPop
        marker3.title = "PSA"
        marker3.snippet = "Physical Sciences"
        marker3.icon = UIImage(named: "ASU-fork-2")
        marker3.map = mySmallMapView
        gmsMarkers.append(marker3)
        
        var marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2DMake(33.420298, -111.931841)
        marker4.appearAnimation = kGMSMarkerAnimationPop
        marker4.title = "Math Center"
        marker4.snippet = "Math Tutoring Center"
        marker4.icon = UIImage(named: "ASU-fork-2")
        marker4.map = mySmallMapView
        gmsMarkers.append(marker4)
        
        var marker5 = GMSMarker()
        marker5.position = CLLocationCoordinate2DMake(33.420056, -111.931327)
        marker5.appearAnimation = kGMSMarkerAnimationPop
        marker5.title = "ERC"
        marker5.snippet = "Engineering Research Center"
        marker5.icon = UIImage(named: "ASU-fork-2")
        marker5.map = mySmallMapView
        gmsMarkers.append(marker5)
        
        var marker6 = GMSMarker()
        marker6.position = CLLocationCoordinate2DMake(33.419331, -111.931273)
        marker6.appearAnimation = kGMSMarkerAnimationPop
        marker6.title = "NOBLE"
        marker6.snippet = "Noble Library & SCOB"
        marker6.icon = UIImage(named: "ASU-fork-2")
        marker6.map = mySmallMapView
        gmsMarkers.append(marker6)
        
        var marker7 = GMSMarker()
        marker7.position = CLLocationCoordinate2DMake(33.419018, -111.931369)
        marker7.appearAnimation = kGMSMarkerAnimationPop
        marker7.title = "ISTB1"
        marker7.snippet = "Interdisciplinary Science and Technology 1"
        marker7.icon = UIImage(named: "ASU-fork-2")
        marker7.map = mySmallMapView
        gmsMarkers.append(marker7)
        
        var marker8 = GMSMarker()
        marker8.position = CLLocationCoordinate2DMake(33.418334, -111.932156)
        marker8.appearAnimation = kGMSMarkerAnimationPop
        marker8.title = "Bookstore"
        marker8.snippet = "Sun Devil Bookstore"
        marker8.icon = UIImage(named: "ASU-fork-2")
        marker8.map = mySmallMapView
        gmsMarkers.append(marker8)
        
    }
    
// start new code
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            mySmallMapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 16.25)
            mySmallMapView.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }
// end new code
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mySmallMapView.myLocationEnabled = true
        }
    }
    
    //self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
    
    deinit {
        mySmallMapView.removeObserver(self, forKeyPath: "myLocation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sending current Tour Point info to Info View Controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toInfo"
        {
            if let infoViewController: InfoViewController = segue.destinationViewController as? InfoViewController {
                infoViewController.pointTitle = tourPoints[currentPoint].title
                infoViewController.pointSnippet = tourPoints[currentPoint].snippet
                infoViewController.pointImage = imgBuilding.image!
                infoViewController.pointIndex = currentPoint
                infoViewController.numPoints = tourPoints.count
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
