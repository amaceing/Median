//
//  NewAssignmentVC.swift
//  Median
//
//  Created by Anthony Mace on 8/6/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class NewAssignmentVC: UIViewController, UITextFieldDelegate {
    //MARK: - Properts
    var assignment: Assignment?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var earnedField: UITextField!
    @IBOutlet weak var possibleField: UITextField!
    
    //MARK: - View Loading Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.earnedField.delegate = self
        self.possibleField.delegate = self
        self.nameField.delegate = self
        if (self.assignment?.name != "") {
            self.navigationItem.title = self.assignment?.name
        } else {
            self.navigationItem.title = "New Assignment"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (self.assignment!.name != "") {
            self.nameField.text = self.assignment?.name
            self.earnedField.text = NSString(format: "%.0f", self.assignment!.pointsEarned!) as String
            self.possibleField.text = NSString(format: "%.0f", self.assignment!.pointsPossible!) as String
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.nameField.text == "") {
            self.assignment?.name = "Assignment"
        } else {
            self.assignment?.name = self.nameField.text!
        }
        self.assignment?.pointsEarned = NSString(string: self.earnedField.text!).doubleValue
        self.assignment?.pointsPossible = NSString(string: self.possibleField.text!).doubleValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
