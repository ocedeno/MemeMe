//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Programming on 8/30/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [MemeClass] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        cell.textLabel?.text = memes[indexPath.item].topText
        
        return cell
    }
}