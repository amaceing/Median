//
//  ClassCircle.swift
//  Median
//
//  Created by Anthony Mace on 5/27/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit
import Darwin

class ClassCircle: UIView {
    var grade: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
        
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //Paths
        var outerSolidGray = UIBezierPath()
        var outerSolidColor = UIBezierPath()
        
        //Percentage of circle to be filled
        var percentage = 85.0
        
        //Setting up points and radius for circle
        var outerPoint = CGPoint(x: 0, y: 28)
        let outerRadius: CGFloat = 26.5
        let line: CGFloat = 20.0
        outerPoint.x += line - 5
        outerPoint.x += outerRadius + 0
        outerSolidGray.lineWidth = 3.25
        
        //Creating gray circle
        outerSolidGray.addArcWithCenter(outerPoint, radius: outerRadius, startAngle: 270, endAngle: 540, clockwise: true)
        UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1).setStroke()
        outerSolidGray.stroke()
        
        //Creating color circle
        if (percentage != 0) {
            outerSolidColor.lineWidth = 3.25
            outerSolidColor.addArcWithCenter(outerPoint, radius: outerRadius, startAngle: degreesToRadians(270), endAngle: degreesToRadians(360 * (percentage / 100) + 270), clockwise: true)
            var colorForCircle = determineUIColor(percentage)
            colorForCircle.setStroke()
            outerSolidColor.stroke()
        }
    }
    
    func degreesToRadians(angle: Double) -> CGFloat {
        return CGFloat(angle / 180.0 * M_PI)
    }
    
    func determineUIColor(percentage: Double) -> UIColor {
        var color: UIColor
        if (percentage >= 85) {
            color = UIColor(red: 124/255.0, green: 209/255.0, blue: 30/255.0, alpha: 1)
        } else if (percentage >= 70) {
            color = UIColor(red: 243/255.0, green: 172/255.0, blue: 54/255.0, alpha: 1)
        } else {
            color = UIColor(red: 233/255.0, green: 69/255.0, blue: 89/255.0, alpha: 1)
        }
        return color
    }
}
