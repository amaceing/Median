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
    @IBOutlet weak var catWeight: UISlider!
    @IBOutlet weak var weightLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.catWeight.continuous = true
        self.catWeight.addTarget(self, action: "showWeight", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.category?.name == "Click to Add") {
            self.navigationItem.title = "New Category"
        } else {
            self.navigationItem.title = "Edit " + self.category!.name
            self.catName.text = self.category?.name
            //self.catWeight.text = String(format: "%.0f", self.category!.weight * 100)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.category!.name = self.catName.text
        //self.category!.weight = weight.doubleValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Logic
    
    func showWeight() {
        var weight = String(format: "Weight: %0.f", catWeight.value)
        self.weightLabel.text = weight
    }
}
