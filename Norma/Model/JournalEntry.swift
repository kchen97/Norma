//
//  JournalEntry.swift
//  Norma
//
//  Created by Korman Chen on 2/17/18.
//  Copyright © 2018 Korman Chen. All rights reserved.
//

import Foundation

enum FormatType : String {
    case pretty = "MMM d, yyyy"
    case ugly = "MM-d-yyyy"
}

class JournalEntry {
    
    var date : Date
    var entry : String
    
    init(_ date : Date, _ entry : String) {
        self.date = date
        self.entry = entry
    }
    
    func convertDateToString(_ format: FormatType) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format.rawValue
        let newDate = dateFormatter.string(from: date)
        
        return newDate
        
    }
}
