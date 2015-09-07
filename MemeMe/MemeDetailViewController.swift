//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Programming on 9/3/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var rowSelected: Int?
    var memes: [MemeClass] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    @IBOutlet weak var memeViewImage: UIImageView!
    
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
        let meme = memes[rowSelected!]
        performSegueWithIdentifier("editMemeVC", sender: meme.image)
    }
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        memes.removeAtIndex(rowSelected!)
        navigationController?.popToRootViewControllerAnimated(true)

    }
    
}

