//
//  Section.swift
//  Sections
//
//  Created by Sayanee Basu on 4/2/16.
//  Copyright © 2016 Sayanee Basu. All rights reserved.
//

import Foundation

struct Section {
    
    var heading: String
    var items: [String]
    
    init(title: String, objects: [String]) {
        heading = title
        items = objects
    }
}
