//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Programming on 8/30/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var rowSelected: Int?
    var appDel: AppDelegate {
        return (UIApplication.sharedApplication().delegate as! AppDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clearColor()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        navigationController?.tabBarController?.tabBar.hidden = false
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDel.memes.count
    }
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        let meme = appDel.memes[indexPath.row]
        
        cell.setTableProperties(meme.topText, bottomText: meme.bottomText, imageViewImage: meme.memedImage)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        rowSelected = indexPath.row
        let meme = appDel.memes[rowSelected!]
        performSegueWithIdentifier("memeDetailView", sender: meme.memedImage)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "memeDetailView") {
            let data = sender as! UIImage
            let memeDetailVC = segue.destinationViewController as! MemeDetailViewController
            memeDetailVC.image = data
            memeDetailVC.rowSelected = rowSelected!
        }
    }
}