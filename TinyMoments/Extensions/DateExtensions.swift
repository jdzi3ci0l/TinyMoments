//
//  DateExtensions.swift
//  TinyMoments
//
//  Created by Janusz on 08/04/2022.
//

import Foundation

extension Date {
    func monthAsString() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMM")
            return df.string(from: self)
    }
    
    var day: Int? {
        return Calendar.current.dateComponents([.day], from: self).day
    }
}
