//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Programming on 8/26/15.
//  Copyright (c) 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func pickImage(sender: UIBarButtonItem){
        let controller = UIImagePickerController()
        controller.delegate = self
        if sender.title == "Album" {
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }else{
            controller.sourceType = UIImagePickerControllerSourceType.Camera
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

