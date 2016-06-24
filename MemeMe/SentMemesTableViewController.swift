//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/14/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    let cellId = "MemeTableCell"
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // MARK: UITableViewDelegate / UITableViewDatasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        let meme = memes[indexPath.item]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.imageView!.image = meme.finalImage
        cell.textLabel!.text = meme.topText + "\\" + meme.bottomText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        
        let editorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditorVC") as! EditorViewController
        self.navigationController?.pushViewController(editorViewController, animated: true)
        editorViewController.memeToLoad = meme
        print("Selected meme", meme)
    }
}
