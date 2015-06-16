//
//  ClassDetailsVC.swift
//  Median
//
//  Created by Anthony Mace on 5/12/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class ClassDetailsVC: UIViewController, UITextFieldDelegate {
    //MARK: - Properties
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var sectionField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    var schoolClass: SchoolClass?
    var strOfDays = ""
    
    @IBOutlet weak var satButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var thuButton: UIButton!
    @IBOutlet weak var wedButton: UIButton!
    @IBOutlet weak var tuesButton: UIButton!
    @IBOutlet weak var monButton: UIButton!
    @IBOutlet weak var sunButton: UIButton!
    //MARK: - View Loading Methods
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.strOfDays = self.schoolClass!.daysOfWeek
        determineButtonsState()
        
        //Title
        if (self.schoolClass?.name == "Click To Add") {
            self.navigationItem.title = "New Class"
        } else {
            self.navigationItem.title = self.schoolClass?.name
        }
        
        //textField delegates
        self.nameField.delegate = self
        self.sectionField.delegate = self
        self.timeField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !(self.schoolClass?.name == "Click To Add") {
            self.nameField.text = self.schoolClass!.name;
            self.sectionField.text = self.schoolClass!.section;
            self.timeField.text = self.schoolClass!.timeOfDay;
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        var newClass = self.schoolClass
        
        newClass!.name = self.nameField.text
        newClass!.section = self.sectionField.text
        newClass!.daysOfWeek = self.strOfDays
        newClass!.timeOfDay = self.timeField.text
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
    
    //MARK: - Button Actions
    
    @IBAction func addClassDay(sender: UIButton) {
        if (sender.highlighted) {
            self.strOfDays = removeDayFromString(sender.titleLabel!.text!, from: self.strOfDays)
        } else {
            self.strOfDays += sender.currentTitle!
            NSLog(self.strOfDays)
        }
    }
    
    func removeDayFromString(remove: String, from: String) -> String {
        return from.stringByReplacingOccurrencesOfString(remove, withString: "", options: nil, range: nil)
    }
    
    func determineButtonsState() {
        if contains(self.strOfDays, containee: self.sunButton.titleLabel?.text) {
            sunButton.highlighted = true
        }
        if contains(self.strOfDays, containee: self.monButton.titleLabel?.text) {
            monButton.highlighted = true
        }
        if contains(self.strOfDays, containee: self.tuesButton.titleLabel?.text) {
            tuesButton.highlighted = true
        }
        if contains(self.strOfDays, containee: self.wedButton.titleLabel?.text) {
            wedButton.highlighted = true
        }
        if contains(self.strOfDays, containee: self.thuButton.titleLabel?.text) {
            thuButton.highlighted = true
        }
        if contains(self.strOfDays, containee: self.friButton.titleLabel?.text) {
            friButton.highlighted = true
        }
        if contains(self.strOfDays, containee: self.satButton.titleLabel?.text) {
            satButton.highlighted = true
        }
    }
    
    func contains(container: String, containee: String?) -> Bool {
        return container.rangeOfString(containee!, options: nil, range: nil, locale: nil) != nil
    }
    
}
