//
//  AllSportDetailView.swift
//  Elite
//
//  Created by Jerry on 16/4/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class AllSportDetailView: UIView {

    var VIEW_WIDTH : CGFloat!
    var VIEW_HEIGHT : CGFloat!
    
    var SportTime:UILabel?
    var SportPlace:UILabel?
    var SportTitle:UILabel?
    var More:UILabel?
    var EditorName:UILabel?
    var cover:UIImageView?
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetRGBStrokeColor(context, 231/255, 231/255, 231/255, 1)
        
        CGContextMoveToPoint(context, 8, VIEW_HEIGHT - 2)
        CGContextAddLineToPoint(context, VIEW_WIDTH - 8, VIEW_HEIGHT - 2)
        CGContextStrokePath(context)
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.VIEW_WIDTH = frame.size.width
        self.VIEW_HEIGHT = frame.size.height
        self.backgroundColor = UIColor.whiteColor()
        
        
        self.cover = UIImageView(frame: CGRectMake(8,8,(VIEW_HEIGHT - 16)/1.273,VIEW_HEIGHT-16))
        self.addSubview(self.cover!)
        
        
        self.SportTitle = UILabel(frame: CGRectMake((VIEW_HEIGHT - 16)/1.273+16,0,VIEW_WIDTH - (VIEW_HEIGHT - 16)/1.273 - 16,VIEW_HEIGHT/4 + 40))
        self.SportTitle?.font = UIFont(name: MY_FONT, size: 18)
        self.SportTitle?.textColor = MAIN_RED
        self.SportTitle?.numberOfLines = 0
        self.SportTitle?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.addSubview(self.SportTitle!)
        
        self.SportTime = UILabel(frame: CGRectMake((VIEW_HEIGHT - 16)/1.273+16,VIEW_HEIGHT/4 + 15,VIEW_WIDTH - (VIEW_HEIGHT - 16)/1.273 - 16,VIEW_HEIGHT/4))
        self.SportTime?.font = UIFont(name: MY_FONT, size: 16)
        self.addSubview(self.SportTime!)
        
        self.SportPlace =  UILabel(frame: CGRectMake((VIEW_HEIGHT - 16)/1.273+16,15 + 8 + VIEW_HEIGHT/4+VIEW_HEIGHT/6,VIEW_WIDTH - (VIEW_HEIGHT - 16)/1.273 - 16,VIEW_HEIGHT/6))
        self.SportPlace?.font = UIFont(name: MY_FONT, size: 15)
        self.addSubview(self.SportPlace!)
        
        self.EditorName = UILabel(frame: CGRectMake((VIEW_HEIGHT - 16)/1.273 + 16, 16 + VIEW_HEIGHT / 4 + (VIEW_HEIGHT / 6)*2, VIEW_WIDTH - (VIEW_HEIGHT - 16)/1.273 - 16, VIEW_HEIGHT / 6 ))
        self.EditorName?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.EditorName!)
        
        self.More = UILabel(frame: CGRectMake((VIEW_HEIGHT - 16)/1.273+16,8+VIEW_HEIGHT/4+VIEW_HEIGHT/6*3,VIEW_WIDTH - (VIEW_HEIGHT - 16)/1.273 - 16,VIEW_HEIGHT/6))
        self.More?.textColor = UIColor.grayColor()
        self.More?.font = UIFont(name: MY_FONT, size: 13)
        self.addSubview(self.More!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
