//
//  TourXMLParser.swift
//  ASU Fulton Engineering Tour
//
//  Created by Mitchell Corbin on 11/24/15.
//  Copyright (c) 2015 Tour Devil. All rights reserved.
//

import Foundation

class TourXMLParser: UIViewController, NSXMLParserDelegate
{
    // Variables to help parse XML File
    var parser: NSXMLParser = NSXMLParser()
    var posts: NSMutableArray = NSMutableArray()
    var elements: NSMutableDictionary = NSMutableDictionary()
    var element: NSString = NSString()
    var pointNum: NSMutableString = NSMutableString()
    var buildingTag: NSMutableString = NSMutableString()
    var buildingName: NSMutableString = NSMutableString()
    var longitude: NSMutableString = NSMutableString()
    var latitude: NSMutableString = NSMutableString()
    var imageURL: NSMutableString = NSMutableString()
    var videoURL: NSMutableString = NSMutableString()
    var directionsText: NSMutableString = NSMutableString()
    var descriptText: NSMutableString = NSMutableString()
    
    // Variables to help store XML Data
    var pointIDs = [String]()
    var pointTitles = [String]()
    var pointSnippets = [String]()
    var pointLats = [String]()
    var pointLongs = [String]()
    
    var imagesECG = [String]()
    var imagesECF = [String]()
    var imagesPSA = [String]()
    var imagesMathCenter = [String]()
    var imagesERC = [String]()
    var imagesNOBLE = [String]()
    var imagesISTB1 = [String]()
    var imagesBookstore = [String]()
    
    var videosECG = [String]()
    var videosECF = [String]()
    var videosPSA = [String]()
    var videosMathCenter = [String]()
    var videosERC = [String]()
    var videosNOBLE = [String]()
    var videosISTB1 = [String]()
    var videosBookstore = [String]()
    
    var directionsECG: String = String()
    var directionsECF: String = String()
    var directionsPSA: String = String()
    var directionsMathCenter: String = String()
    var directionsERC: String = String()
    var directionsNOBLE: String = String()
    var directionsISTB1: String = String()
    var directionsBookstore: String = String()
    
    var descriptionECG: String = String()
    var descriptionECF: String = String()
    var descriptionPSA: String = String()
    var descriptionMathCenter: String = String()
    var descriptionERC: String = String()
    var descriptionNOBLE: String = String()
    var descriptionISTB1: String = String()
    var descriptionBookstore: String = String()
    
    func beginParsing()
    {
        posts = []
        let path = NSBundle.mainBundle().pathForResource("defaultTour-2", ofType: "xml")
        parser = NSXMLParser(contentsOfURL: NSURL(string: "http://tourdevil.fulton.asu.edu/resources/defaultTour-5.xml"))!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        element = elementName
        if (elementName as NSString).isEqualToString("point")
        {
            elements = NSMutableDictionary()
            elements = [:]
            pointNum = NSMutableString()
            pointNum = ""
            buildingTag = NSMutableString()
            buildingTag = ""
            buildingName = NSMutableString()
            buildingName = ""
            longitude = NSMutableString()
            longitude = ""
            latitude = NSMutableString()
            latitude = ""
            directionsText = NSMutableString()
            directionsText = ""
            descriptText = NSMutableString()
            descriptText = ""
        }
        
        if (elementName as NSString).isEqualToString("imageURL")
        {
            imageURL = NSMutableString()
            imageURL = ""
        }
        
        if (elementName as NSString).isEqualToString("videoURL")
        {
            videoURL = NSMutableString()
            videoURL = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        if element.isEqualToString("pointNum")
        {
            pointNum.appendString(string!)
        }
        if element.isEqualToString("buildingTag")
        {
            buildingTag.appendString(string!)
        }
        if element.isEqualToString("buildingName")
        {
            buildingName.appendString(string!)
        }
        if element.isEqualToString("longitude")
        {
            longitude.appendString(string!)
        }
        if element.isEqualToString("latitude")
        {
            latitude.appendString(string!)
        }
        if element.isEqualToString("imageURL")
        {
            imageURL.appendString(string!)
        }
        if element.isEqualToString("videoURL")
        {
            videoURL.appendString(string!)
        }
        if element.isEqualToString("directionsText")
        {
            directionsText.appendString(string!)
        }
        if element.isEqualToString("descriptionText")
        {
            descriptText.appendString(string!)
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqualToString("point")
        {
            
            if !pointNum.isEqual(nil)
            {
                elements.setObject(pointNum, forKey: "pointNum")
                //println("Point Number: \(pointNum)")
                
                pointIDs.append(pointNum as String)
            }
            if !buildingTag.isEqual(nil)
            {
                elements.setObject(buildingTag, forKey: "buildingTag")
                //println("Building Tag: \(buildingTag)")
                
                pointTitles.append(buildingTag as String)
            }
            if !buildingName.isEqual(nil)
            {
                elements.setObject(buildingName, forKey: "buildingName")
                //println("Building Name: \(buildingName)")
                
                pointSnippets.append(buildingName as String)
            }
            if !longitude.isEqual(nil)
            {
                elements.setObject(longitude, forKey: "longitude")
                //println("Longitude: \(longitude)")
                
                pointLongs.append(longitude as String)
            }
            if !latitude.isEqual(nil)
            {
                elements.setObject(latitude, forKey: "latitude")
                //println("Latitude: \(latitude)")
                
                pointLats.append(latitude as String)
            }
            if !directionsText.isEqual(nil)
            {
                elements.setObject(directionsText, forKey: "directionsText")
                //println("Directions Text: \(directionsText)")
                
                if buildingTag.containsString("ECG")
                {
                    directionsECG = directionsText as String
                }
                if buildingTag.containsString("ECF")
                {
                    directionsECF = directionsText as String
                }
                if buildingTag.containsString("PSA")
                {
                    directionsPSA = directionsText as String
                }
                if buildingTag.containsString("Math Center")
                {
                    directionsMathCenter = directionsText as String
                }
                if buildingTag.containsString("ERC")
                {
                    directionsERC = directionsText as String
                }
                if buildingTag.containsString("NOBLE")
                {
                    directionsNOBLE = directionsText as String
                }
                if buildingTag.containsString("ISTB1")
                {
                    directionsISTB1 = directionsText as String
                }
                if buildingTag.containsString("Bookstore")
                {
                    directionsBookstore = directionsText as String
                }
            }
            if !descriptText.isEqual(nil)
            {
                elements.setObject(descriptText, forKey: "descriptionText")
                //println("Description Text: \(descriptText)")
                
                if buildingTag.containsString("ECG")
                {
                    descriptionECG = descriptText as String
                }
                if buildingTag.containsString("ECF")
                {
                    descriptionECF = descriptText as String
                }
                if buildingTag.containsString("PSA")
                {
                    descriptionPSA = descriptText as String
                }
                if buildingTag.containsString("Math Center")
                {
                    descriptionMathCenter = descriptText as String
                }
                if buildingTag.containsString("ERC")
                {
                    descriptionERC = descriptText as String
                }
                if buildingTag.containsString("NOBLE")
                {
                    descriptionNOBLE = descriptText as String
                }
                if buildingTag.containsString("ISTB1")
                {
                    descriptionISTB1 = descriptText as String
                }
                if buildingTag.containsString("Bookstore")
                {
                    descriptionBookstore = descriptText as String
                }
            }
            
            posts.addObject(elements)
        }
        
        if (elementName as NSString).isEqualToString("imageURL")
        {
            if !imageURL.isEqual(nil)
            {
                elements.setObject(imageURL, forKey: "imageURL")
                //println("Image URL: \(imageURL)")
                
                if buildingTag.containsString("ECG")
                {
                    imagesECG.append(imageURL as String)
                }
                if buildingTag.containsString("ECF")
                {
                    imagesECF.append(imageURL as String)
                }
                if buildingTag.containsString("PSA")
                {
                    imagesPSA.append(imageURL as String)
                }
                if buildingTag.containsString("Math Center")
                {
                    imagesMathCenter.append(imageURL as String)
                }
                if buildingTag.containsString("ERC")
                {
                    imagesERC.append(imageURL as String)
                }
                if buildingTag.containsString("NOBLE")
                {
                    imagesNOBLE.append(imageURL as String)
                }
                if buildingTag.containsString("ISTB1")
                {
                    imagesISTB1.append(imageURL as String)
                }
                if buildingTag.containsString("Bookstore")
                {
                    imagesBookstore.append(imageURL as String)
                }
            }
            
            posts.addObject(elements)
        }
        
        if (elementName as NSString).isEqualToString("videoURL")
        {
            if !videoURL.isEqual(nil)
            {
                elements.setObject(videoURL, forKey: "videoURL")
                //println("Video URL: \(videoURL)")
                
                if buildingTag.containsString("ECG")
                {
                    videosECG.append(videoURL as String)
                }
                if buildingTag.containsString("ECF")
                {
                    videosECF.append(videoURL as String)
                }
                if buildingTag.containsString("PSA")
                {
                    videosPSA.append(videoURL as String)
                }
                if buildingTag.containsString("Math Center")
                {
                    videosMathCenter.append(videoURL as String)
                }
                if buildingTag.containsString("ERC")
                {
                    videosERC.append(videoURL as String)
                }
                if buildingTag.containsString("NOBLE")
                {
                    videosNOBLE.append(videoURL as String)
                }
                if buildingTag.containsString("ISTB1")
                {
                    videosISTB1.append(videoURL as String)
                }
                if buildingTag.containsString("Bookstore")
                {
                    videosBookstore.append(videoURL as String)
                }
            }
            
            posts.addObject(elements)
        }
        
    }
    
    // Method to help assure data is stored
    func printArrays()
    {
        for (var i = 0; i < pointIDs.count; i++)
        {
            println(pointIDs[i])
        }
        
        for (var i = 0; i < imagesECG.count; i++)
        {
            println(imagesECG[i])
        }
        println()
        for (var i = 0; i < imagesECF.count; i++)
        {
            println(imagesECF[i])
        }
        println()
        for (var i = 0; i < imagesPSA.count; i++)
        {
            println(imagesPSA[i])
        }
        println()
        for (var i = 0; i < imagesMathCenter.count; i++)
        {
            println(imagesMathCenter[i])
        }
        println()
        for (var i = 0; i < imagesERC.count; i++)
        {
            println(imagesERC[i])
        }
        println()
        for (var i = 0; i < imagesNOBLE.count; i++)
        {
            println(imagesNOBLE[i])
        }
        println()
        for (var i = 0; i < imagesISTB1.count; i++)
        {
            println(imagesISTB1[i])
        }
        println()
        for (var i = 0; i < imagesBookstore.count; i++)
        {
            println(imagesBookstore[i])
        }
        
        println()
        for (var i = 0; i < videosECG.count; i++)
        {
            println(videosECG[i])
        }
        println()
        for (var i = 0; i < videosECF.count; i++)
        {
            println(videosECF[i])
        }
        println()
        for (var i = 0; i < videosPSA.count; i++)
        {
            println(videosPSA[i])
        }
        println()
        for (var i = 0; i < videosMathCenter.count; i++)
        {
            println(videosMathCenter[i])
        }
        println()
        for (var i = 0; i < videosERC.count; i++)
        {
            println(videosERC[i])
        }
        println()
        for (var i = 0; i < videosNOBLE.count; i++)
        {
            println(videosNOBLE[i])
        }
        println()
        for (var i = 0; i < videosISTB1.count; i++)
        {
            println(videosISTB1[i])
        }
        println()
        for (var i = 0; i < videosBookstore.count; i++)
        {
            println(videosBookstore[i])
        }
    }
}