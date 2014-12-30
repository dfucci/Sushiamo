//
//  APIController.swift
//  Sushiamo
//
//  Created by Davide Fucci on 30/12/14.
//  Copyright (c) 2014 Davide Fucci. All rights reserved.
//

import Foundation
class APIController {
    
    var delegate: APIControllerProtocol?
    
    init() {
    }
    
    
    func getRestaurantList(){
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
                    self.delegate?.didReceiveAPIResults(object)
                    //self.tableData.addObject(object)
                    
                }
            } else {
                // Log details of the failure
                println(error.userInfo!)
            }
            //self.restaurantsTableView.reloadData()
        }
    }
}

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: PFObject)
}

