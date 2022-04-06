//
//  JournalEntryCell.swift
//  TinyMoments
//
//  Created by Janusz on 06/04/2022.
//

import UIKit

class JournalEntryCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
