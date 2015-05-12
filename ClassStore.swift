//
//  ClassStore.swift
//  Median
//
//  Created by Anthony Mace on 5/11/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import Foundation

class ClassStore: NSObject {
    
    class var instance: ClassStore {
        struct Static {
            static let instance = ClassStore()
        }
        return Static.instance
    }
    var classArray: [SchoolClass] = []
    
    
    override init() {
        super.init()
        NSLog("self.init()")
        let path: String = self.classArchivePath()
        NSLog(path)
        var unarchiveObj = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! [SchoolClass]
        self.classArray = unarchiveObj
    }
    
    func classArchivePath() -> String {
        var documentDirectories =
        NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var documentDirectory: String = documentDirectories.first! as! String
        return documentDirectory.stringByAppendingPathComponent("data.archive")
    }
    
    func saveChanges() -> Bool {
        var path: String = self.classArchivePath()
        NSLog(path)
        return NSKeyedArchiver.archiveRootObject(self.classArray, toFile: path)
    }
    
    func allClasses() -> [SchoolClass] {
        return self.classArray
    }
    
    func addClass(classToAdd: SchoolClass) {
        self.classArray.append(classToAdd)
        NSLog("adding %@", classToAdd.name)
    }
    
    func removeClass(schoolClass: SchoolClass) {
        let index = find(self.classArray, schoolClass)
        self.classArray.removeAtIndex(index!)
    }
}