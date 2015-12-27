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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.determineClassLabelFontSize()
        self.classLabel.text = self.schoolClass.name
        self.setUpAddButton()
        self.tableViewSetUp()
        self.detailLabelsSetUp()
    }
    
    func determineClassLabelFontSize() {
        if (self.schoolClass.name.characters.count >= 25) {
            self.classLabel.font = UIFont(name: "Lato-Regular.ttf", size: 15)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.gradeLabelSetUp()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func tableViewSetUp() {
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelectionDuringEditing = true
        let nib = UINib(nibName: "AssignmentCategoryCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "AssignmentCategoryCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.separatorColor = UIColor.lightGrayColor()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        self.tableView.tableFooterView = UIView()
    }
    
    func gradeLabelSetUp() {
        let textColor = UIColor()
        self.gradeLabel.textColor = textColor.determineUIColor(self.schoolClass.grade)
        self.gradeLabel.text = String(format: "%2.1f", self.schoolClass.grade)
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
        self.addCat.setTitle("Edit", forState: UIControlState.Normal)
        self.addCat.addTarget(self, action: "addAssignmentCategory", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setUpDoneButton() {
        self.addCat.setTitle("Done", forState: UIControlState.Normal)
        self.addCat.addTarget(self, action: "removeDummyAssignCat", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //MARK: - Logic
    
    func addAssignmentCategory() {
        self.tableView.editing = true
        let assignCatToAdd = AssignmentCategory(name: "Click to Add", weight: 0)
        self.schoolClass.addAssignmentCategory(assignCatToAdd)
        //Insertion
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.addCat.removeTarget(self, action: "addAssignmentCategory", forControlEvents: UIControlEvents.TouchUpInside)
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
        let count = self.schoolClass.assignmentCategories.count
        return count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Implement
        let cell: AssignmentCategoryCell = tableView.dequeueReusableCellWithIdentifier("AssignmentCategoryCell", forIndexPath: indexPath) as! AssignmentCategoryCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let cat = self.schoolClass.assignmentCategoryAtIndex(indexPath.row)
        self.fillCellWithContentsFromCategory(cell, category: cat)
        self.addGradeBarToCell(cell, grade: cat.average!)
        return cell
    }
    
    func fillCellWithContentsFromCategory(cell: AssignmentCategoryCell, category: AssignmentCategory) {
        cell.catName.text = category.name
        let string = String(format: "%0.1f", category.average!)
        cell.catGrade.text = string
        cell.catWeight.text = String(format: "%.0f/100", category.weight * 100)
    }
    
    func addGradeBarToCell(cell: AssignmentCategoryCell, grade: Double) {
        cell.catBar.setNeedsDisplay()
        cell.catBar.layoutIfNeeded()
        let rect = CGRect(x: 0, y: 0, width: cell.catBar.bounds.size.width * (CGFloat(grade) / 100), height: 10)
        let coloredBar = UIView(frame: rect)
        let backGroundColor = UIColor()
        coloredBar.backgroundColor = backGroundColor.determineUIColor(grade)
        cell.catBar.addSubview(coloredBar)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cat = self.schoolClass.assignmentCategoryAtIndex(indexPath.row)
        if (self.tableView.editing) {
            if (cat.name == "Click to Add") {
                self.pushNewAssignmentCategoryVCWithCat(cat)
            } else {
                self.setUpAndPresentAlertController()
            }
        }
        else {
            self.pushAssignCatVCWithCat(cat)
        }
    }
    
    func pushNewAssignmentCategoryVCWithCat(category: AssignmentCategory) {
        let newAssignCatVC = NewAssignmentCategory(nibName: "NewAssignmentCategory", bundle: nil)
        newAssignCatVC.category = category
        self.navigationController?.pushViewController(newAssignCatVC, animated: true)
    }
    
    func setUpAndPresentAlertController() {
        let editDeleteController = UIAlertController(title: "Edit or Delete", message: "Deleting categories cannot be undone", preferredStyle: UIAlertControllerStyle.ActionSheet)
        self.addActionsToController(editDeleteController)
        self.presentViewController(editDeleteController, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    func pushAssignCatVCWithCat(category: AssignmentCategory) {
        let assignCatVC = AssignmentCategoryVC(nibName: "AssignmentCategoryVC", bundle: nil)
        assignCatVC.category = category
        self.navigationController?.pushViewController(assignCatVC, animated: true)
    }
    
    func addActionsToController(controller: UIAlertController) {
        let indexPath = self.tableView.indexPathForSelectedRow!
        let assignCat = self.schoolClass.assignmentCategories[indexPath.row]
        //Actions
        let delete = UIAlertAction(title: "Delete",
                                    style: UIAlertActionStyle.Destructive,
                                    handler: {(alert: UIAlertAction) in
                                                self.schoolClass.removeAssignmentCategory(assignCat)
                                                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                                                self.gradeLabelSetUp()
                                             })
        let edit = UIAlertAction(title: "Edit",
                                    style: UIAlertActionStyle.Default,
                                    handler: {(alert: UIAlertAction) in
                                                self.pushNewAssignmentCategoryVCWithCat(assignCat)
                                             })
        let cancel = UIAlertAction(title: "Cancel",
                                    style: UIAlertActionStyle.Destructive,
                                    handler: {(alert: UIAlertAction) in
                                                controller.dismissViewControllerAnimated(true, completion: nil)
                                             })
        controller.addAction(delete)
        controller.addAction(edit)
        controller.addAction(cancel)
    }

}
