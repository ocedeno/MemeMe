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
        
        tableView.separatorColor = UIColor.clearColor()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        let meme = memes[indexPath.row]
        
        cell.setTableProperties(meme.topText, bottomText: meme.bottomText, imageViewImage: meme.memedImage)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        performSegueWithIdentifier("memeDetailView", sender: meme.memedImage)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "memeDetailView") {
            let data = sender as! UIImage
            let memeDetailVC = segue.destinationViewController as! MemeDetailViewController
            memeDetailVC.image = data
        }
    }
}