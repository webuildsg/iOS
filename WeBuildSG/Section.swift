//
//  Section.swift
//  Sections
//
//  Created by Sayanee Basu on 4/2/16.
//  Copyright © 2016 Sayanee Basu. All rights reserved.
//

import Foundation

struct Item {
    var name: String
    var description: String
    var by: String
    var rsvp: String
}

struct Section {
    
    var heading: String
    var objects: [Item]
    
    init(title: String, items: [Item]) {
        heading = title
        objects = items
    }
}
