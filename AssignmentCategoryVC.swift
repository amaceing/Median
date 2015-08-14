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
    var alertController: UIAlertController
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Loading Methods
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.category = AssignmentCategory()
        self.alertController = UIAlertController(title: "Edit or Delete Assignment", message: "Deleting Assignments cannot be undone", preferredStyle: UIAlertControllerStyle.ActionSheet)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addActionsToControllerForAssignment(self.alertController)
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
        self.navigationController?.presentViewController(self.alertController, animated: true, completion: nil)
    }

    func addActionsToControllerForAssignment(controller: UIAlertController) {
        //Actions
        let delete = UIAlertAction(title: "Delete",
            style: UIAlertActionStyle.Destructive,
            handler: {(alert: UIAlertAction!) in
                let pathAndAssignment = self.chooseAssignmentForAlertControllerAndIndexPath()
                let path = pathAndAssignment.0
                let assignment = pathAndAssignment.1
                self.category.removeAssignment(assignment)
                self.tableView.deleteRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Fade)
                self.gradeLabelSetUp()
        })
        let edit = UIAlertAction(title: "Edit",
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in
                let pathAndAssignment = self.chooseAssignmentForAlertControllerAndIndexPath()
                let assignment = pathAndAssignment.1
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
    
    func chooseAssignmentForAlertControllerAndIndexPath() -> (NSIndexPath, Assignment) {
        let indexPath = self.tableView.indexPathForSelectedRow()!
        var assignment = self.category.assignmentList[indexPath.row]
        return (indexPath, assignment)
    }
    
}
