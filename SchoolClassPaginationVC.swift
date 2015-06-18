//
//  SchoolClassPaginationVC.swift
//  Median
//
//  Created by Anthony Mace on 6/18/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class SchoolClassPaginationVC: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavBar()
    }
    
    func setUpNavBar() {
        var title = " "
        let navBarBlue = UIColor(red: 30/255.0, green: 178/255.0, blue: 192/255.0, alpha: 1)
        self.navigationItem.title = title.determineSeasonAndYear()
        self.navigationController?.navigationBar.barTintColor = navBarBlue
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Lato-Regular", size: 24)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - PageVC Methods
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //Implement later
        let vc = UIViewController()
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        //Implement later
        let vc = UIViewController()
        return vc
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
