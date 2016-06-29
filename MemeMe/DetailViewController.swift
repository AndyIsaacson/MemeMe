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
    
    var memeToLoad : Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meme = memeToLoad {
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            imageView.image = meme.originImage

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
}
