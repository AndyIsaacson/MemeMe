//
//  SampleMemes.swift
//  MemeMe
//
//  Created by Andy Isaacson on 6/22/16.
//  Copyright © 2016 Andy Isaacson. All rights reserved.
//

import UIKit

func makeSampleMemeList() -> [Meme] {
    var memes = [Meme]()
    
    let inigoMeme = Meme(topText: "Hello!  My name is", bottomText: "Swifty.  How are you?", originImage: UIImage(named: "InigoUnfilled")!, finalImage: UIImage(named: "InigoFilled")!)
    
    memes.append(inigoMeme)
    memes.append(inigoMeme)

    memes.append(inigoMeme)

    
    return memes
}
