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
        self.tableViewSetUp()
        self.gradeLabelSetUp()
        self.detailLabelsSetUp()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolClass.assignmentCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Implement
        var cell: AssignmentCategoryCell = tableView.dequeueReusableCellWithIdentifier("AssignmentCategoryCell", forIndexPath: indexPath) as! AssignmentCategoryCell
        return cell
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
