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
        self.gradeLabelSetUp()
        self.tableView.reloadData()
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
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
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
        //Insertion
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
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
            var textColor = UIColor()
            cell.gradeLabel.textColor = textColor.determineUIColor(assignment.gradeEarned!)
            gradeText = String(format: "%.1f", assignment.gradeEarned!)
            cell.gradeLabel.text = gradeText
        }
        return cell
    }

}
