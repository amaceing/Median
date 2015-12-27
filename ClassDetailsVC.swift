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
    
    var schoolClass: SchoolClass?
    var strOfDays = ""
    let startTimeFormatter = NSDateFormatter()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var sectionField: UITextField!
    @IBOutlet weak var startTime: UIDatePicker!
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
        self.startTimeFormatter.dateFormat = "h:mm a"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.strOfDays = self.schoolClass!.daysOfWeek
        determineButtonsState()
        
        //Title
        if (self.schoolClass?.name == "Click to Add") {
            self.navigationItem.title = "New Class"
        } else {
            self.navigationItem.title = self.schoolClass?.name
        }
        
        //textField delegates
        self.nameField.delegate = self
        self.sectionField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !(self.schoolClass?.name == "Click to Add") {
            self.nameField.text = self.schoolClass!.name;
            self.sectionField.text = self.schoolClass!.section;
            self.startTime.date = self.startTimeFormatter.dateFromString(self.schoolClass!.timeOfDay)!
        } else {
            self.nameField.text = ""
            self.sectionField.text = ""
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.schoolClass!.name = self.nameField.text!
        self.schoolClass!.section = self.sectionField.text!
        self.schoolClass!.daysOfWeek = self.strOfDays
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
    
    @IBAction func saveStartingTime(sender: UIButton) {
        let time = self.startTimeFormatter.stringFromDate(self.startTime.date)
        self.schoolClass!.timeOfDay = time
    }
    
    @IBAction func addClassDay(sender: UIButton) {
        if (contains(self.strOfDays, containee: sender.titleLabel?.text)) {
            self.strOfDays = removeDayFromString(sender.titleLabel!.text!, from: self.strOfDays)
            sender.setTitleColor(UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1), forState: UIControlState.Normal)
        } else {
            addDayInPlace(sender.currentTitle!)
            sender.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 195/255.0, alpha: 1), forState: UIControlState.Normal)
            NSLog(self.strOfDays)
        }
    }
    
    func addDayInPlace(dayToAdd: String) {
        var newStrOfDays = ""
        switch dayToAdd {
            case "Su":
                newStrOfDays = self.strOfDays.insert("Su", atIndex: 1)
            case "M":
                newStrOfDays = self.strOfDays.insert("M", atIndex: 2)
            case "T":
                newStrOfDays = self.strOfDays.insert("T", atIndex: 3)
            case "W":
                newStrOfDays = self.strOfDays.insert("W", atIndex: 4)
            case "R":
                newStrOfDays = self.strOfDays.insert("R", atIndex: 5)
            case "F":
                newStrOfDays = self.strOfDays.insert("F", atIndex: 6)
            case "Sa":
                newStrOfDays = self.strOfDays.insert("Sa", atIndex: 7)
            default:
                break
        }
        self.strOfDays = newStrOfDays
    }
    
    func removeDayFromString(remove: String, from: String) -> String {
        return from.stringByReplacingOccurrencesOfString(remove, withString: "", options: [], range: nil)
    }
    
    func determineButtonsState() {
        if contains(self.strOfDays, containee: self.sunButton.titleLabel?.text) {
            sunButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
        if contains(self.strOfDays, containee: self.monButton.titleLabel?.text) {
            monButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
        if contains(self.strOfDays, containee: self.tuesButton.titleLabel?.text) {
            tuesButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
        if contains(self.strOfDays, containee: self.wedButton.titleLabel?.text) {
            wedButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
        if contains(self.strOfDays, containee: self.thuButton.titleLabel?.text) {
            thuButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
        if contains(self.strOfDays, containee: self.friButton.titleLabel?.text) {
            friButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
        if contains(self.strOfDays, containee: self.satButton.titleLabel?.text) {
            satButton.setTitleColor(UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1), forState: UIControlState.Normal)
        }
    }
    
    func contains(container: String, containee: String?) -> Bool {
        return container.rangeOfString(containee!, options: [], range: nil, locale: nil) != nil
    }
    
}
