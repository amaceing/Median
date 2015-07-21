 //
//  SemesterVC.swift
//  Median
//
//  Created by Anthony Mace on 5/11/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

extension String {
    func determineSeasonAndYear() -> String {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMonth | .CalendarUnitYear, fromDate:  NSDate())
        let month = components.month
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy"
        var yearString = formatter.stringFromDate(NSDate())
        if (month >= 1 && month <= 5) {
            return String(format: "Spring %@", yearString)
        } else if (month >= 6 && month <= 8) {
            return String(format: "Summer %@", yearString)
        } else if (month >= 9 && month <= 12) {
            return String(format: "Fall %@", yearString)
        }
        return ""
    }
}

class SemesterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    
    @IBOutlet weak var _seasonTitle: UILabel!
    var seasonTitle: UILabel!{
        get {
            var title = " "
            let textColor = UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1)
            let font = UIFont(name: "Lato-Regular", size: 18)
            self._seasonTitle.text = title.determineSeasonAndYear()
            self._seasonTitle.textColor = textColor
            self._seasonTitle.font = font
            return self._seasonTitle
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Loading Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.seasonTitle //setting seasonTitle text
        self.setNavBarProperties()
        self.setUpEditButton()
        self.tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "SchoolClassCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "SchoolClassCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.separatorColor = UIColor.lightGrayColor()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpEditButton() {
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addSchoolClass:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func setUpDoneButton() {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneEditing:")
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func setUpBackButton() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func setNavBarProperties() {
        self.navigationItem.title = "Classes"
        var navBarBlue = UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = navBarBlue
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lato-Regular", size: 24)!]
    }
    
    // MARK: - Logic
    
    func addSchoolClass(sender: UIBarButtonItem) {
        var clickToAdd: SchoolClass = SchoolClass(name: "Click to Add", section: "101", daysOfWeek: "MWF", timeOfDay: "12:00 PM")
        var store = ClassStore.instance
        store.addClass(clickToAdd, atIndex: 0)
        
        //Insertion animation
        var row = 0
        var path: NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.editing = true
        self.tableView.allowsSelectionDuringEditing = true
        self.setUpDoneButton()
    }
    
    func doneEditing(sender: UIBarButtonItem) {
        var schoolClassToDelete = ClassStore.instance.allClasses()[0]
        if (schoolClassToDelete.name == "Click to Add") {
            ClassStore.instance.removeClass(schoolClassToDelete)
            
            //Deletion Animation
            let row = 0
            let path = NSIndexPath(forRow: row, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        self.editing = false
        self.setUpEditButton()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows term in the section.
        var count = ClassStore.instance.allClasses().count
        return count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SchoolClassCell = tableView.dequeueReusableCellWithIdentifier("SchoolClassCell", forIndexPath: indexPath) as! SchoolClassCell
        var index = indexPath.row
        var schoolClassForCell = ClassStore.instance.allClasses()[index]
        
        // Configure the cell...
        var classCircle: ClassCircle = makeCircleForClassCell(schoolClassForCell)
        let con = UIGraphicsGetCurrentContext()
        cell.contentView.addSubview(classCircle)
        classCircle.setNeedsDisplay()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.intGrade.frame = determineGradeLabelFrameWithGrade(90.6)
        self.fillCellWithContentFromClass(cell, schoolClass: schoolClassForCell)

        return cell
    }
    
    func fillCellWithContentFromClass(cell: SchoolClassCell, schoolClass: SchoolClass) {
        //load strings from schoolClass
        var section = schoolClass.valueForKey("section") as! String
        var daysOfWeek = schoolClass.valueForKey("daysOfWeek") as! String
        var timeOfDay = schoolClass.valueForKey("timeOfDay") as! String
        cell.schoolClassName.text = schoolClass.name
        cell.schoolClassDetails.text = NSString(format: "%@  ∙ %@ ∙  %@", section, daysOfWeek, timeOfDay) as String
        let intAndDec = self.getIntAndDecFromGrade(schoolClass.grade)
        cell.intGrade.text = String(format: "%.0f", intAndDec.0.description)
        if (schoolClass.grade >= 100 || schoolClass.grade == 0) {
            cell.decGrade.text = "";
        } else {
            cell.decGrade.text = String(format: ".%.0f", intAndDec.1.description)
        }
    }
    
    func getIntAndDecFromGrade(grade: Double) -> (Double, Double) {
        let wholeNum = grade.getWholeNumberFromGrade()
        let decimal = grade.getDecimalFromGrade()
        return (wholeNum, decimal)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var schoolClassToPresent: SchoolClass = ClassStore.instance.allClasses()[indexPath.row]
        let classIndex = indexPath.row
        if (self.editing) {
            var classDetailsVC = ClassDetailsVC(nibName: "ClassDetailsVC", bundle: nil)
            classDetailsVC.schoolClass = schoolClassToPresent
            self.navigationController?.pushViewController(classDetailsVC, animated: true)
        } else {
            let cpvc = SchoolClassPaginationVC(index: classIndex)
            self.navigationController?.pushViewController(cpvc, animated: true)
        }
    }

    func determineGradeLabelFrameWithGrade(grade: Double) -> CGRect {
        let gradeRect: CGRect;
        if (grade >= 100) {
            gradeRect = CGRectMake(20, 35, 41, 25);
        } else {
            gradeRect = CGRectMake(11, 35, 41, 25);
        }
        return gradeRect;
    }
    
    func makeCircleForClassCell(sc: SchoolClass) -> ClassCircle {
        var frame: CGRect = CGRectMake(5, 20, 85, 85);
        var classCircle: ClassCircle = ClassCircle(frame: frame)
        classCircle.grade = sc.grade
        return classCircle
    }
    
}
