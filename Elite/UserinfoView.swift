//
//  UserinfoView.swift
//  Elite
//
//  Created by Jerry on 16/4/25.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

@objc protocol UserinfoDelegate{
    optional func choicePhoto()
}


class UserinfoView: UIView {
    
    weak var delegate:UserinfoDelegate?
    
    var UserName:UILabel?
    var Email:UILabel?
    var Cover:UIButton?
    var PhoneNumber:UILabel?
    var userlabel:UILabel?
    
    var EmailString = ""
    var UserNameEmailString = ""
    var labelEmailString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.Cover = UIButton(frame: CGRectMake(SCREEN_WIDTH - 120 ,8+40,110,114))
        self.Cover?.setImage(UIImage(named: "touxiang"), forState: .Normal)
        self.Cover?.layer.masksToBounds = true
        self.Cover?.layer.cornerRadius = 10
        self.addSubview(self.Cover!)
        self.Cover?.addTarget(self, action: #selector(UserinfoDelegate.choicePhoto), forControlEvents: .TouchUpInside)
        
        
        self.UserName = UILabel(frame: CGRectMake(10,130,SCREEN_WIDTH-128-45,30))
        //self.UserName?.floatingLabelFont = UIFont(name: MY_FONT, size: 18)
        self.UserName?.font = UIFont(name: MY_FONT, size: 14)
        self.UserName?.backgroundColor = buttoncolor
        self.UserName?.textColor = UIColor.whiteColor()
        self.UserName?.textAlignment = .Center
        self.addSubview(self.UserName!)
        
        self.userlabel = UILabel(frame: CGRectMake(10,90,SCREEN_WIDTH-128-15,30))
        self.userlabel?.font = UIFont(name: MY_FONT, size: 20)
        self.userlabel?.textColor = UIColor.blackColor()
        self.userlabel?.text = " 用户名："
        self.addSubview(self.userlabel!)
        
        self.Email = UILabel(frame: CGRectMake(10,180,SCREEN_WIDTH - 20,30))
        self.Email?.font = UIFont(descriptor: UIFontDescriptor(), size: 15)
        self.Email?.backgroundColor = buttoncolor
        self.Email?.textColor = UIColor.whiteColor()
        self.Email?.textAlignment = .Center
        self.addSubview(self.Email!)
        
        self.PhoneNumber = UILabel(frame: CGRectMake(10, 240,SCREEN_WIDTH - 20,30))
        self.PhoneNumber?.font = UIFont(name: MY_FONT, size: 15)
        self.PhoneNumber?.textColor = UIColor.whiteColor()
        self.PhoneNumber?.backgroundColor = buttoncolor
        self.PhoneNumber?.textAlignment = .Center
        self.addSubview(self.PhoneNumber!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func choicePhoto(){
        self.delegate?.choicePhoto!()
    }
    
}
