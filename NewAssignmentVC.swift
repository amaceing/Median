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
    
    required init(coder aDecoder: NSCoder) {
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
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.assignment!.name = self.nameField.text
        self.assignment?.pointsEarned = NSString(string: self.earnedField.text).doubleValue
        self.assignment?.pointsPossible = NSString(string: self.possibleField.text).doubleValue
        //self.assignment?.gradeEarned = NSString(string: self.gradeField.text).doubleValue
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
