//
//  tourPoints.swift
//  ASU Fulton Engineering Tour
//
//  Created by suzanne germano on 5/11/15.
//  Copyright (c) 2015 Tour Devil. All rights reserved.
//

import Foundation

class TourPoints{
    var id: Int!
    var pointLatitude: Double!
    var pointLongitude: Double!
    var title: String!
    var snippet: String!
/*
   init(id: Int, pointLatitude: Double, pointLongitude: Double, title: String, snippet: String)
    {
        self.id = id
        self.pointLongitude = pointLongitude
        self.pointLatitude = pointLatitude
        self.title = title
        self.snippet = snippet
    }
*/
/*
    init(data: NSDictionary)
    {
        self.id = data["id"] as! Int
        self.longitude = data["long"] as! Double
        self.latitude = data["lat"] as! Double
        self.title = data["title"] as! String
        self.snippet = data["snippet"] as! String
    }
 */
    func getLat() -> Double{
        return pointLatitude
    }
    
    func getLong() ->Double{
        return pointLongitude
    }
    
    func getTitle()->String{
        return title
    }
    
    func getSnippet()->String{
        return snippet
    }
    

}