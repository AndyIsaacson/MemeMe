//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/14/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    let cellId = "SentMemeCollectionViewCell"
    
    override func viewDidLoad() {
        collectionView?.registerClass(SentMemeCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // MARK: UICollectionViewDelegate / UICollectionViewDatasource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let meme = memes[indexPath.item]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SentMemeCollectionViewCell
        cell.imageView.image = meme.finalImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        print("Selected meme", meme)
    }
}
