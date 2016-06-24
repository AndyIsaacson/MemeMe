//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/14/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    let cellId = "MemeCollectionCell"
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    // MARK: UICollectionViewDelegate / UICollectionViewDatasource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let meme = memes[indexPath.item]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SentMemeCollectionViewCell
        cell.imageView?.image = meme.finalImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        
        let editorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditorVC") as! EditorViewController
        self.navigationController?.pushViewController(editorViewController, animated: true)
        editorViewController.memeToLoad = meme
        print("Selected meme", meme)
    }
}
