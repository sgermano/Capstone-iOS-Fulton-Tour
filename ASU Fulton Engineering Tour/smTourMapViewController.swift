
//
//  smTourMapViewController.swift
//  ASU Fulton Engineering Tour
//
//  Created by Suzanne Germano on 4/22/15.
//  Copyright (c) 2015 Germano. All rights reserved.
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
        let originCoordinate = (NSString(format: "%.15f", tourPoints[currentPoint].pointLatitude) as String) + "," + (NSString(format: "%.15f", tourPoints[currentPoint].pointLongitude) as String)
        
        let destinationCoordinate = (NSString(format: "%.15f", tourPoints[nextPoint].pointLatitude) as String) + "," + (NSString(format: "%.15f", tourPoints[nextPoint].pointLongitude) as String)
        var waypointsArray: Array<String> = []
        getDirections(originCoordinate, destination : destinationCoordinate, waypoints : nil, travelMode : "walking", completionHandler: { (status, success) -> Void in
            if success {
                self.configureMapAndMarkersForRoute()
                self.drawRoute()
                self.displayRouteInfo()
            }
            else {
                println(status)
            }
        })

        
        //self.mySmallMapView.camera = camera
        

        
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
        
        let destImage = markerNext.title + ".jpg"
        imgBuilding.image =  UIImage(named: destImage)
        lblText.text = markerNext.snippet
        self.mySmallMapView.camera = camera
        if (currentPoint == tourPoints.count-1){
           currentPoint = 0
        }
        else{
            currentPoint++
        }
    
        if (nextPoint == tourPoints.count-1){
            nextPoint = 0}
        else{
            nextPoint++}
    }
    
    func drawRoute(){
        let route = overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)
        routePolyline = GMSPolyline(path: path)
        routePolyline.map = mySmallMapView
        routePolyline.strokeWidth = 5
        routePolyline.strokeColor = UIColor.blackColor()
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
        marker3.position = CLLocationCoordinate2DMake(33.41947836, -111.93689704)
        marker3.appearAnimation = kGMSMarkerAnimationPop
        marker3.title = "COOR"
        marker3.snippet = "Latte Coor"
        marker3.icon = UIImage(named: "ASU-fork-2")
        marker3.map = mySmallMapView
        gmsMarkers.append(marker3)
        
        // brickyard 33.423732, -111.939438
        var marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2DMake(33.423732, -111.939438)
        marker4.appearAnimation = kGMSMarkerAnimationPop
        marker4.title = "BYENG"
        marker4.snippet = "Brickyard Engineering"
        marker4.icon = UIImage(named: "ASU-fork-2")
        marker4.map = mySmallMapView
        gmsMarkers.append(marker4)
        
        //centerpoint 33.423802, -111.940870
        var marker5 = GMSMarker()
        marker5.position = CLLocationCoordinate2DMake(33.423802, -111.940870)
        marker5.appearAnimation = kGMSMarkerAnimationPop
        marker5.title = "CTRPT"
        marker5.snippet = "Center Point"
        marker5.icon = UIImage(named: "ASU-fork-2")
        marker5.map = mySmallMapView
        gmsMarkers.append(marker5)
        
        // CAVC 33.423345, -111.935736
        var marker6 = GMSMarker()
        marker6.position = CLLocationCoordinate2DMake(33.423345, -111.935736)
        marker6.appearAnimation = kGMSMarkerAnimationPop
        marker6.title = "CAVC"
        marker6.snippet = "College Ave Commons"
        marker6.icon = UIImage(named: "ASU-fork-2")
        marker6.map = mySmallMapView
        gmsMarkers.append(marker6)
        
    }
    
// start new code
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            mySmallMapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 13.0)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
