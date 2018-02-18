//
//  JournalEntry.swift
//  Norma
//
//  Created by Korman Chen on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import Foundation

class JournalEntry {
    
    var month : String?
    var year : String?
    var entry : String?
    
    init(_ month : String, _ year : String, _ entry : String) {
        self.month = month
        self.year = year
        self.entry = entry
    }
}
