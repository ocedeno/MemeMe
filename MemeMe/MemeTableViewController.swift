//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Programming on 8/30/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes = [MemeClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewController", forIndexPath: indexPath) as? MemeTableViewController
        cell
    }
}