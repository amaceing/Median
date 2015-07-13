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
    
    
    //MARK: - View loading methods
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
    
    func setUpAddButton() {
        self.addCat.addTarget(self, action: "addAssignmentCategory", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setUpDoneButton() {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = doneButton
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
    
    //MARK: - Logic
    func addAssignmentCategory() {
        var assignCatToAdd = AssignmentCategory(name: "Click to Add", weight: 0)
        self.schoolClass.addAssignmentCategory(assignCatToAdd)
        
        //Insertion
        let row = 0
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.tableView.editing = true
        self.tableView.allowsSelectionDuringEditing = true
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
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
