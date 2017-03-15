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

    var memeStruct: MemeStruct?
    var memedImage: UIImage?

    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName : -1.5
    ] as [String : Any]

    override func viewDidLoad() {
        super.viewDidLoad()

        designatingTextAttributes(topTextField)
        designatingTextAttributes(bottomTextField)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(MemeEditorViewController.shareMeme))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.tabBarController?.tabBar.isHidden = true
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)

        subscribeToKeyboardNotifications()
                
        if (memedImage != nil){
            imageView.image = memedImage
        }
        
        if imageView.image == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
        }else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.tabBarController?.tabBar.isHidden = false
        
        unsubscribeFromKeyboardNotification()
    }
    
    func designatingTextAttributes(_ textField: UITextField){
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = "EDIT TEXT"
    }

    @IBAction func pickImage(_ sender: UIBarButtonItem){
        let controller = UIImagePickerController()
        controller.delegate = self
            if sender.title == "Album" {
                controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            }else{
                controller.sourceType = UIImagePickerControllerSourceType.camera
            }
        present(controller, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [AnyHashable: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            navigationItem.leftBarButtonItem?.isEnabled = true
        } else {
            let errorAlertController = UIAlertController()
            errorAlertController.title = "Issue in Selecting Image"
            errorAlertController.message = "Could not set the image to the view."
            let okAction = UIAlertAction(title: "Dismiss", style: .default){ action in
                self.dismiss(animated: true, completion: nil)
                }
            errorAlertController.addAction(okAction)
            self.present(errorAlertController, animated: true, completion: nil)
            
            print("Could not set image to view.")
        }

        dismiss(animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = true
    }

    @IBAction func cancelSharing(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }

    func generateMemedImage() -> UIImage {
        navigationController?.setNavigationBarHidden(true, animated: true)
        toolBar.isHidden = true

        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        navigationController?.setNavigationBarHidden(false, animated: true)
        toolBar.isHidden = false

        return memedImage
    }

    func shareMeme() {
        saveMeme()
        let controller = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activy, completed, items, error) in
            if (completed){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        present(controller, animated: true, completion: nil)
    }

    func saveMeme() {
        memedImage = generateMemedImage()
        
        let meme = MemeStruct(topText: topTextField.text, bottomText: bottomTextField.text, image: imageView.image!, memedImage: memedImage!)

        let object = UIApplication.shared.delegate
        let appDelegate = object as? AppDelegate
        appDelegate?.memes.append(meme)
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
            view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
