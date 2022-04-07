//
//  Entry.swift
//  TinyMoments
//
//  Created by Janusz on 06/04/2022.
//

import Foundation

class Entry {
    let date: Date
    var title: String
    var text: String = ""
    var mood: String?
    
    init(date: Date = Date.now, title: String, text: String, mood: String? = nil) {
        self.date = date
        self.title = title
        self.text = text
        self.mood = mood
    }
}
