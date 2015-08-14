//
//  AssignmentCategoryVC.swift
//  Median
//
//  Created by Anthony Mace on 8/3/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class AssignmentCategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    
    var category: AssignmentCategory
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Loading Methods
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.category = AssignmentCategory()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = self.category.name
        self.tableViewSetUp()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedCell = self.tableView.indexPathForSelectedRow() {
            self.tableView.deselectRowAtIndexPath(selectedCell, animated: false)
        }
        self.gradeLabelSetUp()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.setUpBackButton()
    }
    
    func gradeLabelSetUp() {
        var textColor = UIColor()
        self.gradeLabel.textColor = textColor.determineUIColor(self.category.average!)
        self.gradeLabel.text = String(format: "%2.1f", self.category.average!)
    }
    
    func tableViewSetUp() {
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "AssignmentCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "AssignmentCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.separatorColor = UIColor.lightGrayColor()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 35, 0, 35)
    }
    
    func setUpBackButton() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Logic
    
    @IBAction func addAssignment(sender: UIButton) {
        self.tableView.editing = true
        var assignmentToAdd = Assignment()
        self.category.addAssignment(assignmentToAdd)
        //Push NewAssignmentVC
        let assignVC = NewAssignmentVC(nibName: "NewAssignmentVC", bundle: nil)
        assignVC.assignment = assignmentToAdd
        self.navigationController?.pushViewController(assignVC, animated: true)
    }
    
    //MARK: - Table View Implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.category.assignmentList.count
        return count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Implement
        var cell: AssignmentCell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell", forIndexPath: indexPath) as! AssignmentCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let assignment = self.category.assignmentAtIndex(indexPath.row)
        cell.assignmentName.text = assignment.name
        if var gradeText = assignment.gradeEarned?.description {
            self.formatGradeTextForCellWithAssignment(cell, assignment: assignment)
        }
        return cell
    }
    
    func formatGradeTextForCellWithAssignment(cell: AssignmentCell, assignment: Assignment) {
        var textColor = UIColor()
        cell.gradeLabel.textColor = textColor.determineUIColor(assignment.gradeEarned!)
        let gradeText = String(format: "%.1f", assignment.gradeEarned!)
        cell.gradeLabel.text = gradeText
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var editAndDeleteController = UIAlertController(title: "Edit or Delete", message: "Deleting Assignments cannot be undone", preferredStyle: UIAlertControllerStyle.ActionSheet)
        self.addActionsToController(editAndDeleteController)
        self.navigationController?.presentViewController(editAndDeleteController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println("test")
    }

    func addActionsToController(controller: UIAlertController) {
        let indexPath = self.tableView.indexPathForSelectedRow()!
        var assignment = self.category.assignmentList[indexPath.row]
        //Actions
        let delete = UIAlertAction(title: "Delete",
            style: UIAlertActionStyle.Destructive,
            handler: {(alert: UIAlertAction!) in
                self.category.removeAssignment(assignment)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                self.gradeLabelSetUp()
        })
        let edit = UIAlertAction(title: "Edit",
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in
                self.pushNewAssignmentVC(assignment)
        })
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Destructive,
            handler: {(alert: UIAlertAction!) in
                controller.dismissViewControllerAnimated(true, completion: nil)
        })
        controller.addAction(delete)
        controller.addAction(edit)
        controller.addAction(cancel)
    }
    
    func pushNewAssignmentVC(assignment: Assignment) {
        let newAssignmentVc = NewAssignmentVC(nibName: "NewAssignmentVC", bundle: nil)
        newAssignmentVc.assignment = assignment
        self.navigationController?.pushViewController(newAssignmentVc, animated: true)
    }
    
}
