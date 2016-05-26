//
//  config.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import Foundation

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width

let SCREEN_HIGHT = UIScreen.mainScreen().bounds.size.height

let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)

let buttoncolor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)

let MY_FONT = "Bauhaus ITC"

func RGB(r:Float,g:Float,b:Float)->UIColor{
    return UIColor(colorLiteralRed: r/255, green: g/255, blue: b/255, alpha: 1)
    
}

let selfsetColor = RGB(241, g: 242, b: 248)
