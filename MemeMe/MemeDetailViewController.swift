//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Programming on 9/3/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeViewImage: UIImageView!
    
    var rowSelected: Int?
    var appDel: AppDelegate {
        return (UIApplication.sharedApplication().delegate as! AppDelegate)
    }
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeViewImage.image = image
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    navigationController?.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    navigationController?.tabBarController?.tabBar.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editMemeVC"){
            let data = sender as? UIImage
            let editMeme = segue.destinationViewController as! MemeEditorViewController
            editMeme.memedImage = data
        }
    }
    
    @IBAction func returnToMemeEditor(sender: UIBarButtonItem) {
        let meme = appDel.memes[rowSelected!]
        performSegueWithIdentifier("editMemeVC", sender: meme.image)
    }
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        let deleteAlert = UIAlertController(title: "Delete Meme?", message: "Are you sure you want to delete this Meme?", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        deleteAlert.addAction(cancelAction)
        let OkAction = UIAlertAction(title: "Delete", style: .Default, handler: {(action) in
            let meme = self.appDel.memes[self.rowSelected!]
            self.appDel.memes.removeAtIndex(self.rowSelected!)
            self.navigationController?.popToRootViewControllerAnimated(true)
        })
        deleteAlert.addAction(OkAction)

        presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
}

