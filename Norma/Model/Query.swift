//
//  Query.swift
//  Norma
//
//  Created by Tim Roesner on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import Foundation

struct Query {
    var text = ""
    var normaTalks = true
    
    init(_ text: String, normaTalks: Bool) {
        self.text = text
        self.normaTalks = normaTalks
    }
}
