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
    @IBOutlet weak var memeContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var memeContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var viewShifted = false
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

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
            let newOffset = getKeyboardHeight(notification) - toolbar.bounds.height
            memeContainerTopConstraint.constant -= newOffset
            memeContainerBottomConstraint.constant += newOffset
            viewShifted = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if viewShifted {
            memeContainerTopConstraint.constant = 0
            memeContainerBottomConstraint.constant = 0
            viewShifted = false
        }
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    @IBAction func shareMeme(sender: AnyObject) {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originImage: memeImageView.image!, finalImage: renderMeme())
        
        let activityViewController = UIActivityViewController(activityItems: [meme.finalImage], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    func renderMeme() -> UIImage {
        UIGraphicsBeginImageContext(self.memeContainerView.frame.size)
        self.memeContainerView.drawViewHierarchyInRect(self.memeContainerView.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return memedImage
    }

    @IBAction func cancelEdit(sender: AnyObject) {
        resetUi()
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

