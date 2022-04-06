//
//  Entry.swift
//  TinyMoments
//
//  Created by Janusz on 06/04/2022.
//

import Foundation

class Entry {
    let date: Date
    var text: String
    
    init(date: Date, text: String) {
        self.date = date
        self.text = text
    }
}
