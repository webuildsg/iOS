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
        
        var items = [Item]()
        items.append(Item(name: "Hello", description: "Description", by: "By by by", rsvp: "23"))
        items.append(Item(name: "Hello 2", description: "Description 2", by: "By by by by", rsvp: "2"))
        
        let animals = Section(title: "Animals", items: items)
        sectionsArray.append(animals)
        
        Alamofire.request(.GET, "https://webuild.sg/api/v1/events?n=10")
            .responseJSON { response in
                if let JSON = response.result.value {
                    var openEventsItems = [Item]()

                    for index in 0...9 {
                        let eventName = JSON["events"]!![index]["name"]! as! String
                        let description = JSON["events"]!![index]["description"]! as! String
                        
                        openEventsItems.append(Item(name: eventName, description: description, by: "By by by by", rsvp: "2"))
                    }
                    
                    let openEvents = Section(title: "Open Events", items: openEventsItems)
                    sectionsArray.append(openEvents)
                    return callback(sections: sectionsArray)
                }
        }
    }
}
