//
//  SchoolClass.swift
//  Median
//
//  Created by Anthony Mace on 5/11/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import Foundation

extension Double {
    func getWholeNumberFromGrade(grade: Double) -> Double {
        let wholeNum = grade
        let decimal = wholeNum.getDecimalFromGrade(grade)
        return wholeNum - decimal
        
    }
    
    func getDecimalFromGrade(grade: Double) -> Double {
        let decimal = grade - floor(grade)
        if (decimal >= 0.95) {
            return 0.1
        }
        return decimal
    }
}

class SchoolClass: NSObject, NSCoding, Equatable {
    var name: String
    var section: String
    var daysOfWeek: String
    var timeOfDay: String
    var assignmentCategories: [AssignmentCategory] = []
    var grade: Double {
        get {
            var classWorths: Double = 0
            var assignCatWeights: Double = 0
            for assignCat in self.assignmentCategories {
                if (assignCat.getCount() > 0) {
                    classWorths += assignCat.calcClassWorth()
                    assignCatWeights += assignCat.weight
                }
            }
            if (assignCatWeights != 0) {
                return (classWorths / assignCatWeights) * 100.0;
            }
            return 0.0
        }
    }
    
    override init() {
        self.name = ""
        self.section = ""
        self.daysOfWeek = ""
        self.timeOfDay = ""
        super.init()
    }
    
    init(name: String, section: String, daysOfWeek: String, timeOfDay: String) {
        self.name = name
        self.section = section
        self.daysOfWeek = daysOfWeek
        self.timeOfDay = timeOfDay
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.section = aDecoder.decodeObjectForKey("section") as! String
        self.daysOfWeek = aDecoder.decodeObjectForKey("daysOfWeek") as! String
        self.timeOfDay = aDecoder.decodeObjectForKey("timeOfDay") as! String
        self.assignmentCategories = aDecoder.decodeObjectForKey("assignmentCategories") as! [AssignmentCategory]
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.section, forKey: "section")
        aCoder.encodeObject(self.daysOfWeek, forKey: "daysOfWeek")
        aCoder.encodeObject(self.timeOfDay, forKey: "timeOfDay")
        aCoder.encodeObject(self.assignmentCategories, forKey: "assignmentCategories")
    }
    
    func getAssignmentCategoryCount() -> Int {
        return self.assignmentCategories.count
    }
    
    func assignCategoryNameAtIndex(index: Int) -> String {
        var assignCat = self.assignmentCategories[index]
        return assignCat.name
    }
    
    func assignmentCategoryAtIndex(index: Int) -> AssignmentCategory {
        return self.assignmentCategories[index]
    }
    
    func addAssignmentCategory(assignCat: AssignmentCategory) {
        self.assignmentCategories.append(assignCat)
    }
    
    func removeAssignmentCategory(assignCat: AssignmentCategory) {
        let index = find(self.assignmentCategories, assignCat)
        self.assignmentCategories.removeAtIndex(index!)
    }
}

func == (lhs: SchoolClass, rhs: SchoolClass) -> Bool {
    return lhs.name == rhs.name && lhs.section == rhs.section
        && lhs.timeOfDay == rhs.timeOfDay
}
