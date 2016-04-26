import Foundation
import Alamofire

class SectionsData {
    func getSectionsFromData(callback: (sections: [Section]) -> ()) {
        var sectionsArray = [Section]()
        let prodEventsUrl = "https://webuild.sg/api/v1/events?n=10"
        let prodReposUrl = "https://webuild.sg/api/v1/repos?n=10"
//         let devEventsUrl = "http://localhost:4000/api/v1/events?n=10"
//         let devReposUrl = "http://localhost:4000/api/v1/repos?n=10"
        
        Alamofire.request(.GET, prodEventsUrl)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var openEventsItems = [Item]()

                    for index in 0...9 {
                        let eventName = JSON["events"]!![index]["name"]! as! String
                        let description = JSON["events"]!![index]["description"]! as! String
                        let date = JSON["events"]!![index]["formatted_time"]! as! String
                        let url = JSON["events"]!![index]["url"]! as! String
                        let by = JSON["events"]!![index]["group_name"]! as! String
                        let rsvp = JSON["events"]!![index]["rsvp_count"]! as! Int
                        let latitude = JSON["events"]!![index]["latitude"]! as? Double ?? 1.3521
                        let longitude = JSON["events"]!![index]["longitude"]! as? Double ?? 103.8198
                        let location = JSON["events"]!![index]["location"]! as! String
                        
                        openEventsItems.append(Item(
                            name: eventName,
                            description: description,
                            date: date,
                            type: "events",
                            url: url,
                            by: by,
                            rsvp: rsvp,
                            latitude: latitude,
                            longitude: longitude,
                            location: location
                        ))
                    }
                    
                    let openEvents = Section(title: "Open Events 👫👬👭", items: openEventsItems)
                    sectionsArray.append(openEvents)
                    
                    Alamofire.request(.GET, prodReposUrl)
                        .responseJSON { response in
                            if let JSON = response.result.value {
                                var openReposItems = [Item]()
                                
                                for index in 0...9 {
                                    let name = JSON["repos"]!![index]["name"]! as! String
                                    let description = JSON["repos"]!![index]["description"]! as! String
                                    let date = JSON["repos"]!![index]["formatted_time"]! as! String
                                    let url = JSON["repos"]!![index]["html_url"]! as! String
                                    
                                    let owner = JSON["repos"]!![index]["owner"]!!["login"]! as! String
                                    let stars = JSON["repos"]!![index]["stargazers_count"]! as! Int
                                    let language = JSON["repos"]!![index]["language"]! as! String
                                    
                                    let by = "\(owner) | \(stars)" + " ⭐️ | " + language
                                    
                                    openReposItems.append(Item(
                                        name: name,
                                        description: description,
                                        date: date,
                                        type: "repos",
                                        url: url,
                                        by: by,
                                        rsvp: stars,
                                        latitude: 1.3521,
                                        longitude: 103.8198,
                                        location: "Singapore"))
                                }
                                
                                let openRepos = Section(title: "Open Repos 🚀 🌳 🤖", items: openReposItems)
                                sectionsArray.append(openRepos)
                                
                                return callback(sections: sectionsArray)
                            }
                    }
                }
        }
    }
}
