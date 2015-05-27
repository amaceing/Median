//
//  ClassCircle.swift
//  Median
//
//  Created by Anthony Mace on 5/27/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class ClassCircle: UIView {
    var grade: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        self.opaque = false
    }
        
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
}
