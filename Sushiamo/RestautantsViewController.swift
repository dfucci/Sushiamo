//
//  ViewController.swift
//  Sushiamo
//
//  Created by Davide Fucci on 07/12/14.
//  Copyright (c) 2014 Davide Fucci. All rights reserved.
//

import UIKit
import Parse
class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    @IBOutlet weak var restaurantsTableView: UITableView!
    var tableData:NSMutableArray = NSMutableArray()
    let kCellIdentifier: String = "RestaurantCell"
    var api = APIController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.api.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        api.getRestaurantList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return self.tableData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        let cellDataParse:PFObject = self.tableData.objectAtIndex(indexPath.row) as PFObject
        
        cell.textLabel?.text = cellDataParse.objectForKey("name") as? String
        cell.detailTextLabel?.text = cellDataParse.objectForKey("address") as? String
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var menuViewController: MenuViewController = segue.destinationViewController as MenuViewController
        var index = restaurantsTableView!.indexPathForSelectedRow()!.row
        var menu = self.tableData[index]["menu"] as? Dictionary<String, Int>
        menuViewController.menu = menu!

    }
    
    func didReceiveAPIResults(results: PFObject) {
      //  var resultsArr: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData.addObject(results)
            self.restaurantsTableView!.reloadData()
        })
    }

}

