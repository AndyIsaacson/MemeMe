//
//  MemeSelector.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/29/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

protocol MemeSelector {
    func launchCreateNewMeme()
    func launchDetailView(meme:Meme)
}

extension MemeSelector where Self: UIViewController {
    func launchCreateNewMeme() {
        let editorNavViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditorNavVC") as! UINavigationController
        self.presentViewController(editorNavViewController, animated: true, completion: nil)
    }
    
    func launchDetailView(meme: Meme) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
        detailViewController.memeToLoad = meme
        self.navigationController?.pushViewController(detailViewController, animated: true)
        print("Selected meme", meme)
    }
}
