//
//  ViewController.swift
//  Sushiamo
//
//  Created by Davide Fucci on 07/12/14.
//  Copyright (c) 2014 Davide Fucci. All rights reserved.
//

import UIKit
import Parse
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableData:NSMutableArray = NSMutableArray()
    @IBOutlet weak var restaurantsTableView: UITableView!
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
                for object:PFObject in objects as [PFObject] {
                    let name = object["name"] as String
                    println(name)
                    self.tableData.addObject(object)
                    
                }
            } else {
                // Log details of the failure
                println(error.userInfo!)
            }
            self.restaurantsTableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return self.tableData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        let cellDataParse:PFObject = self.tableData.objectAtIndex(indexPath.row) as PFObject
        
        cell.textLabel?.text = cellDataParse.objectForKey("name") as? String
        cell.detailTextLabel?.text = cellDataParse.objectForKey("address") as? String
        
        return cell
    }

}

