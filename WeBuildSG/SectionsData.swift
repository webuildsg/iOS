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
         let prodEventsUrl = "https://webuild.sg/api/v1/events?n=10"
         let prodReposUrl = "https://webuild.sg/api/v1/repos?n=10"
        // let devEventsUrl = "http://localhost:4000/api/v1/events?n=10"
        // let devReposUrl = "http://localhost:4000/api/v1/events?n=10"
        
        Alamofire.request(.GET, prodEventsUrl)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var openEventsItems = [Item]()

                    for index in 0...9 {
                        let eventName = JSON["events"]!![index]["name"]! as! String
                        let description = JSON["events"]!![index]["description"]! as! String
                        let date = JSON["events"]!![index]["formatted_time"]! as! String
                        
                        openEventsItems.append(Item(name: eventName, description: description, date: date, by: "By by by by", rsvp: "2"))
                    }
                    
                    let openEvents = Section(title: "Open Events", items: openEventsItems)
                    sectionsArray.append(openEvents)
                    
                    Alamofire.request(.GET, prodReposUrl)
                        .responseJSON { response in
                            if let JSON = response.result.value {
                                var openReposItems = [Item]()
                                
                                for index in 0...9 {
                                    let name = JSON["repos"]!![index]["name"]! as! String
                                    let description = JSON["repos"]!![index]["description"]! as! String
                                    let date = JSON["repos"]!![index]["pushed_at"]! as! String
                                    
                                    openReposItems.append(Item(name: name, description: description, date: date, by: "By by by by", rsvp: "2"))
                                }
                                
                                let openRepos = Section(title: "Open Repositories", items: openReposItems)
                                sectionsArray.append(openRepos)
                                
                                return callback(sections: sectionsArray)
                            }
                    }
                }
        }
    }
}
