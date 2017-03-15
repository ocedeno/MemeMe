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
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeViewImage.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editMemeVC"){
            let data = sender as? UIImage
            let editMeme = segue.destination as! MemeEditorViewController
            editMeme.memedImage = data
        }
    }
    
    @IBAction func returnToMemeEditor(_ sender: UIBarButtonItem) {
        let meme = appDel.memes[rowSelected!]
        performSegue(withIdentifier: "editMemeVC", sender: meme.image)
    }
    
    @IBAction func deleteMeme(_ sender: UIBarButtonItem) {
        let deleteAlert = UIAlertController(title: "Delete Meme?", message: "Are you sure you want to delete this Meme?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        deleteAlert.addAction(cancelAction)
        let OkAction = UIAlertAction(title: "Delete", style: .default, handler: {(action) in
            let meme = self.appDel.memes[self.rowSelected!]
            self.appDel.memes.remove(at: self.rowSelected!)
            self.navigationController?.popToRootViewController(animated: true)
        })
        deleteAlert.addAction(OkAction)

        present(deleteAlert, animated: true, completion: nil)
    }
    
}

