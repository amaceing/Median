//
//  NewAssignmentCategory.swift
//  Median
//
//  Created by Anthony Mace on 7/13/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class NewAssignmentCategory: UIViewController {
    var category: AssignmentCategory?
    @IBOutlet weak var catName: UITextField!
    @IBOutlet weak var catWeight: UITextField!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.category?.name == "Click to Add") {
            self.navigationItem.title = "New Category"
        } else {
            self.navigationItem.title = "Edit " + self.category!.name
            self.catName.text = self.category?.name
            self.catWeight.text = String(format: "%.0f", self.category!.weight * 100)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.category!.name = self.catName.text
        let weight: NSString = self.catWeight.text
        self.category!.weight = weight.doubleValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
