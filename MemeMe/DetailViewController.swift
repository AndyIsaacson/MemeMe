//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/28/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let tapRecognizer = UITapGestureRecognizer()
    
    var memeToLoad : Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapRecognizer.addTarget(self, action: #selector(self.dismissDetailVC))
        self.view.addGestureRecognizer(tapRecognizer)
        
        if let meme = memeToLoad {
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            imageView.image = meme.originImage

        }
    }
    
    func dismissDetailVC() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
