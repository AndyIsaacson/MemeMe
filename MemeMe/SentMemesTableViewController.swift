//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/14/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // MARK: UITableViewDelegate / UITableViewDatasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "MemeTableCell"
        
        let meme = memes[indexPath.item]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.imageView!.image = meme.finalImage
        cell.textLabel!.text = meme.topText + "\\" + meme.bottomText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        print("Selected meme", meme)
    }
}
