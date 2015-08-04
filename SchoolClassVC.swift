//
//  SchoolClassVC.swift
//  Median
//
//  Created by Anthony Mace on 6/18/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class SchoolClassVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Properties
    
    var schoolClass: SchoolClass
    var index: NSInteger
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCat: UIButton!
    
    //MARK: - View Loading Methods
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, index: NSInteger, schoolClass: SchoolClass) {
        self.schoolClass = schoolClass
        self.index = index
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.schoolClass = SchoolClass()
        self.index = 0
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.classLabel.text = self.schoolClass.name
        self.setUpAddButton()
        self.tableViewSetUp()
        self.gradeLabelSetUp()
        self.detailLabelsSetUp()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableViewSetUp() {
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "AssignmentCategoryCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "AssignmentCategoryCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.separatorColor = UIColor.lightGrayColor()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        //self.tableView.tableFooterView = UIView()
    }
    
    func gradeLabelSetUp() {
        let textColor: UIColor
        if (self.schoolClass.grade >= 85) {
            textColor = UIColor(red:124/255.0, green:209/255.0, blue:30/255.0 ,alpha:1)
        } else if (self.schoolClass.grade >= 70) {
            textColor = UIColor(red:243/255.0, green:172/255.0, blue:54/255.0 ,alpha:1)
        } else {
            textColor = UIColor(red:233/255.0, green:69/255.0, blue:89/255.0 ,alpha:1)
        }
        self.gradeLabel.textColor = textColor
        self.gradeLabel.text = self.schoolClass.grade.description
    }
    
    func detailLabelsSetUp() {
        let details = String(format: "%@    ●  %@  ●    %@", self.schoolClass.section, self.schoolClass.daysOfWeek, self.schoolClass.timeOfDay)
        self.detailsLabel.text = details
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gradeTextSetUp() {
        var gradeLabelsRect = self.determineGradeLabelsFrame()
    }
    
    func determineGradeLabelsFrame() -> CGRect {
        var gradeLabelsRect: CGRect
        if (self.schoolClass.grade >= 99.95) {
            gradeLabelsRect = CGRectMake(57, 84, 280, 80);
        } else {
            gradeLabelsRect = CGRectMake(22, 84, 280, 80);
        }
        return gradeLabelsRect
    }
    
    func setUpAddButton() {
        self.addCat.setTitle("Add", forState: UIControlState.Normal)
        self.addCat.addTarget(self, action: "addAssignmentCategory", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setUpDoneButton() {
        self.addCat.setTitle("Done", forState: UIControlState.Normal)
        self.addCat.addTarget(self, action: "removeDummyAssignCat", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //MARK: - Logic
    
    func addAssignmentCategory() {
        var assignCatToAdd = AssignmentCategory(name: "Click to Add", weight: 0)
        self.schoolClass.addAssignmentCategory(assignCatToAdd)
        //Insertion
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.addCat.removeTarget(self, action: "addAssignmentCategory", forControlEvents: UIControlEvents.TouchUpInside)
        self.tableView.allowsSelectionDuringEditing = true
        self.setUpDoneButton()
    }
    
    func removeDummyAssignCat() {
        let deleteCat = self.schoolClass.assignmentCategoryAtIndex(0)
        if (deleteCat.name == "Click to Add") {
            self.schoolClass.removeAssignmentCategory(deleteCat)
            //Deletion
            let path = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Left)
        }
        self.addCat.removeTarget(self, action: "removeDummyAssignCat", forControlEvents: UIControlEvents.TouchUpInside)
        self.setUpAddButton()
    }
    
    //MARK: - Table View Implemenation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolClass.assignmentCategories.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Implement
        var cell: AssignmentCategoryCell = tableView.dequeueReusableCellWithIdentifier("AssignmentCategoryCell", forIndexPath: indexPath) as! AssignmentCategoryCell
        let cat = self.schoolClass.assignmentCategoryAtIndex(indexPath.row)
        self.fillCellWithContentsFromCategory(cell, category: cat)
        return cell
    }
    
    func fillCellWithContentsFromCategory(cell: AssignmentCategoryCell, category: AssignmentCategory) {
        cell.catName.text = category.name
        cell.catGrade.text = String(format: "%0.1f", category.average!)
        cell.catWeight.text = String(format: "%.0f/100", category.weight * 100)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cat = self.schoolClass.assignmentCategoryAtIndex(indexPath.row)
        if (self.tableView.editing) {
            if (cat.name == "Click to Add") {
                let newAssignCatVC = NewAssignmentCategory(nibName: "NewAssignmentCategory", bundle: nil)
                newAssignCatVC.category = cat
                self.navigationController?.pushViewController(newAssignCatVC, animated: true)
            }
        } else {
            //Push AssignCatTVC
        }
    }

}
