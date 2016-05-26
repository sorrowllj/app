//
//  GeneralFactory.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class GeneralFactory: NSObject {
    
    static func addTitleWith(target:UIViewController,title1:String = "关闭",title2:String = "确认"){
        let btn1 = UIButton(frame: CGRectMake(10,30,40,20))
        btn1.setTitle(title1, forState: .Normal)
        btn1.contentHorizontalAlignment = .Left
        btn1.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
        
        btn1.titleLabel?.font = UIFont(name: MY_FONT, size: 20)
        btn1.tag = 1234
        target.view.addSubview(btn1)
        
        
        
        let btn2 = UIButton(frame: CGRectMake(SCREEN_WIDTH - 50,30,40,20))
        btn2.setTitle(title2, forState: .Normal)
        btn2.contentHorizontalAlignment = .Right
        btn2.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
        btn2.titleLabel?.font = UIFont(name: MY_FONT, size: 20)
        btn2.tag = 1235
        target.view.addSubview(btn2)
        
        
        btn1.addTarget(target, action: #selector(NSStream.close), forControlEvents: .TouchUpInside)
        btn2.addTarget(target, action: #selector(NSStream.open), forControlEvents: .TouchUpInside)
    }
}