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
    
    @IBAction func didTouchAdd(sender: AnyObject) {
        let editorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditorVC") as! EditorViewController
        editorViewController.willResetOnAppear = true
        self.navigationController?.pushViewController(editorViewController, animated: true)
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
        
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
        detailViewController.memeToLoad = meme
        self.presentViewController(detailViewController, animated: true, completion: nil)
        
        print("Selected meme", meme)

    }
    
}
