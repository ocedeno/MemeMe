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
    @IBOutlet weak var toolBar: UIToolbar!

    var memeClass: MemeClass?
    var memedImage: UIImage?

    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName : -1.5
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        designatingTextAttributes(topTextField)
        designatingTextAttributes(bottomTextField)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareMeme")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.tabBarController?.tabBar.hidden = true
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

        subscribeToKeyboardNotifications()
                
        if (memedImage != nil){
            imageView.image = memedImage
        }
        
        if imageView.image == nil {
            navigationItem.leftBarButtonItem?.enabled = false
        }else {
            navigationItem.leftBarButtonItem?.enabled = true
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.tabBarController?.tabBar.hidden = false
        
        unsubscribeFromKeyboardNotification()
    }
    
    func designatingTextAttributes(textField: UITextField){
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.text = "EDIT TEXT"
    }

    @IBAction func pickImage(sender: UIBarButtonItem){
        let controller = UIImagePickerController()
        controller.delegate = self
            if sender.title == "Album" {
                controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            }else{
                controller.sourceType = UIImagePickerControllerSourceType.Camera
            }
        presentViewController(controller, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            navigationItem.leftBarButtonItem?.enabled = true
        } else {
            let errorAlertController = UIAlertController()
            errorAlertController.title = "Issue in Selecting Image"
            errorAlertController.message = "Could not set the image to the view."
            let okAction = UIAlertAction(title: "Dismiss", style: .Default){ action in
                self.dismissViewControllerAnimated(true, completion: nil)
                }
            errorAlertController.addAction(okAction)
            self.presentViewController(errorAlertController, animated: true, completion: nil)
            
            print("Could not set image to view.")
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        textField.clearsOnBeginEditing = true
    }

    @IBAction func cancelSharing(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    func generateMemedImage() -> UIImage {
        navigationController?.setNavigationBarHidden(true, animated: true)
        toolBar.hidden = true

        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        navigationController?.setNavigationBarHidden(false, animated: true)
        toolBar.hidden = false

        return memedImage
    }

    func shareMeme() {
        saveMeme()
        let controller = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activy, completed, items, error) in
            if (completed){
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(controller, animated: true, completion: nil)
    }

    func saveMeme() {
        memedImage = generateMemedImage()
        
        let meme = MemeClass(topText: topTextField.text, bottomText: bottomTextField.text, image: imageView.image!, memedImage: memedImage!)

        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as? AppDelegate
        appDelegate?.memes.append(meme)
    }
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder(){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
            view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
}
