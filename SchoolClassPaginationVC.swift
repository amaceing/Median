//
//  SchoolClassPaginationVC.swift
//  Median
//
//  Created by Anthony Mace on 6/18/15.
//  Copyright (c) 2015 Mace. All rights reserved.
//

import UIKit

class SchoolClassPaginationVC: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll,
                                                                        navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal,
                                                                        options: nil)
    var startIndex: NSInteger?
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.startIndex = index
        self.view.backgroundColor = UIColor.whiteColor()
        self.setUpPageViewController()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpNavBar()
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
    
    func setUpPageViewController() {
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        
        var initialViewController = self.viewControllerAtIndex(self.startIndex!)
        var viewControllers = NSArray(object: initialViewController)
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - PageVC Methods
    func viewControllerAtIndex(index: NSInteger) -> SchoolClassVC {
        var sc = ClassStore.instance.allClasses()[index]
        var childVC = SchoolClassVC(nibName: "SchoolClassVC", bundle: nil, index: index, schoolClass: sc)
        return childVC
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        //Implement later
        let vc = viewController as! SchoolClassVC
        var index = vc.index
        if (index == 0) {
            return nil
        }
        index = --index
        return self.viewControllerAtIndex(index)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //Implement later
        let schoolClassCount = ClassStore.instance.allClasses().count
        let vc = viewController as! SchoolClassVC
        var index = vc.index
        index = ++index
        if (index == schoolClassCount) {
            return nil
        }
        return self.viewControllerAtIndex(index)
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
