//
//  Section.swift
//  Sections
//
//  Created by Sayanee Basu on 4/2/16.
//  Copyright © 2016 Sayanee Basu. All rights reserved.
//

import Foundation

struct Item {
    var name: String // Event / Repository name
    var description: String // Description
    var date: String // Event date / Repository pushed date
    var type: String // "events" or "repos"
    var url: String
    var by: String // Event group / Repository owner
    var rsvp: Int?
    var latitude: Double?
    var longitude: Double?
    var location: String
    var start: NSDate?
    var end: NSDate?
}

struct Section {
    
    var heading: String
    var objects: [Item]
    
    init(title: String, items: [Item]) {
        heading = title
        objects = items
    }
}
