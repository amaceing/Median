//
//  AssignmentCell.swift
//  Median
//
//  Created by Anthony Mace on 8/4/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class AssignmentCell: UITableViewCell {
    //MARK: - Properties

    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var assignmentName: UILabel!
    
    //MARK: - View Loading Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
