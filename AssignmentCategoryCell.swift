//
//  AssignmentCategoryCell.swift
//  Median
//
//  Created by Anthony Mace on 6/19/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class AssignmentCategoryCell: UITableViewCell {

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catGrade: UILabel!
    @IBOutlet weak var catWeight: UILabel!
    @IBOutlet weak var catBar: UIView!
    
    
    
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
        for view in self.catBar.subviews as! [UIView] {
            if view.isKindOfClass(UIView) {
                view.removeFromSuperview()
                view.setNeedsDisplay()
            }
        }
    }
    
}
