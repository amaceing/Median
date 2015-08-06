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
        var textColor = UIColor()
        self.gradeLabel.textColor = textColor.determineUIColor(self.schoolClass.grade)
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
        self.tableView.editing = true
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
        self.tableView.editing = false
        let deleteCat = self.schoolClass.assignmentCategoryAtIndex(0)
        if (deleteCat.name == "Click to Add") {
            self.schoolClass.removeAssignmentCategory(deleteCat)
            //Deletion
            let path = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Fade)
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
        println(category.weight)
        cell.catName.text = category.name
        cell.catGrade.text = String(format: "%0.1f", category.average!)
        cell.catWeight.text = String(format: "%.0f/100", category.weight * 100)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cat = self.schoolClass.assignmentCategoryAtIndex(indexPath.row)
        if (cat.name == "Click to Add" || self.tableView.editing) {
            let newAssignCatVC = NewAssignmentCategory(nibName: "NewAssignmentCategory", bundle: nil)
            newAssignCatVC.category = cat
            self.navigationController?.pushViewController(newAssignCatVC, animated: true)
        } else {
            let assignCatVC = AssignmentCategoryVC(nibName: "AssignmentCategoryVC", bundle: nil)
            assignCatVC.category = cat
            self.navigationController?.pushViewController(assignCatVC, animated: true)
        }
    }

}
