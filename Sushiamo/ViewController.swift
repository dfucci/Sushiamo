//
//  ViewController.swift
//  Sushiamo
//
//  Created by Davide Fucci on 07/12/14.
//  Copyright (c) 2014 Davide Fucci. All rights reserved.
//

import UIKit
import Parse
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var query = PFQuery(className:"Restaurants")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) restaurant.")
                // Do something with the found objects
                for object in objects {
                    let name = object["name"] as String
                    println(name)
                }
            } else {
                // Log details of the failure
                println(error.userInfo!)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

