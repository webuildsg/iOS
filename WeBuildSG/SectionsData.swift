//
//  SectionsData.swift
//  Sections
//
//  Created by Sayanee Basu on 4/2/16.
//  Copyright © 2016 Sayanee Basu. All rights reserved.
//

import Foundation
import Alamofire

class SectionsData {
    func getSectionsFromData(callback: (sections: [Section]) -> ()) {
        var sectionsArray = [Section]()
        
        let animals = Section(title: "Animals", objects:  ["Cats", "Dogs", "Lions", "Birds"], place: "Jungle")
        let vehicles = Section(title: "Vehicles", objects: ["Cars", "Bicycle"], place: "Road")
        let movies = Section(title: "Movies", objects: ["Sound", "Music"], place: "Cinema")
        
        sectionsArray.append(animals)
        sectionsArray.append(vehicles)
        sectionsArray.append(movies)
        
        Alamofire.request(.GET, "https://webuild.sg/api/v1/events?n=10")
            .responseJSON { response in
                if let JSON = response.result.value {
                    var openEvents = Section(title: "Open Events", objects: [], place: "Rooms")
                    for index in 0...9 {
                        let eventName = JSON["events"]!![index]["name"]! as! String
                        // let startTime = JSON["events"]!![index]["start_time"]!
                        print("Event: \(eventName)")
                        // print("When: \(startTime!)")
                        print("\r\n")
                        
                        openEvents.items.append(eventName)
                    }
                    
                    sectionsArray.append(openEvents)
                    
                    return callback(sections: sectionsArray)
                    
                }
        }
    }
}
