//
//  SchoolClassCell.swift
//  Median
//
//  Created by Anthony Mace on 6/13/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class SchoolClassCell: UITableViewCell {
    @IBOutlet weak var schoolClassName: UILabel!
    @IBOutlet weak var schoolClassDetails: UILabel!
    @IBOutlet weak var intGrade: UILabel!
    @IBOutlet weak var decGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in self.contentView.subviews {
            //remove circle view from superView
            if view.isKindOfClass(UILabel) {
                view.setNeedsDisplay()
            }
        }
    }
}

