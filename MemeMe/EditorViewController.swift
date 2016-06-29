//
//  EditorViewController
//  MemeMe
//
//  Created by Andy Isaacson on 5/2/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var memeContainerView: UIView!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: MemeTextField!
    @IBOutlet weak var bottomTextField: MemeTextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!

    
    var tabBarFrame : CGRect?
    
    var willResetOnAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.defaultText = "TOP"
        bottomTextField.defaultText = "BOTTOM"
        
        topTextField.modifiedNotifierBlocks.append({self.updateShareButton()})
        bottomTextField.modifiedNotifierBlocks.append({self.updateShareButton()})
        
        resetUi()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        addNotifications()
        
        //tabBarFrame = self.tabBarController?.tabBar.frame
        //self.tabBarController?.tabBar.frame = CGRectZero
        //self.tabBarController?.tabBar.hidden = true
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        if willResetOnAppear {
            resetUi()
            willResetOnAppear = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeNotifications()
        
        if let tabBarFrame = tabBarFrame {
            self.tabBarController?.tabBar.frame = tabBarFrame
        }
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.setToolbarHidden(true, animated: false)

    }
    
    func addNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func setMeme(meme: Meme) {
        resetUi()
        topTextField.text = meme.topText
        bottomTextField.text = meme.bottomText
        memeImageView.image = meme.originImage
    }
    
    func resetUi() {
        topTextField.reset()
        bottomTextField.reset()
        memeImageView.image = nil
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    func updateShareButton() {
        shareButton.enabled = memeImageView.image != nil && bottomTextField.modified && topTextField.modified
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            let newOffset = getKeyboardHeight(notification)
            view.frame.origin.y = -newOffset
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

    @IBAction func shareMeme(sender: AnyObject) {
        let finalImage = renderMeme()
        
        
        let activityViewController = UIActivityViewController(activityItems: [finalImage], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems:[AnyObject]?, error: NSError?) in
            let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originImage: self.memeImageView.image!, finalImage: finalImage)
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
            print("appended Meme")
            self.cancelEdit(self)
        }
        
    }
    
    func renderMeme() -> UIImage {
        UIGraphicsBeginImageContext(self.memeContainerView.frame.size)
        memeContainerView.drawViewHierarchyInRect(self.memeContainerView.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return memedImage
    }

    @IBAction func cancelEdit(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openCamera(sender: AnyObject) {
        pickImage(.Camera)
    }
    
    @IBAction func openAlbum(sender: AnyObject) {
        pickImage(.PhotoLibrary)
    }
    
    func pickImage(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info["UIImagePickerControllerMediaType"] as! String == "public.image" {
            self.memeImageView.image = info["UIImagePickerControllerOriginalImage"] as! UIImage?
        }
        dismissViewControllerAnimated(true, completion: nil)
        updateShareButton()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        updateShareButton()
    }
    
}

