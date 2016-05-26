//
//  SelfSportTabBar.swift
//  Elite
//
//  Created by Jerry on 16/4/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

protocol SelfSportTabBarDelegate {
    func comment()
    func commentController()
    func likeSport(btn:UIButton)
}

class SelfSportTabBar: UIView {

    var delegate:SelfSportTabBarDelegate?

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.whiteColor()
        let imageName = ["Pen 4","chat 3","heart"]
        
        for i in 0..<3 {
            let btn = UIButton(frame: CGRectMake(CGFloat(i)*frame.size.width/3,0,frame.size.width/3,frame.size.height))
            btn.setImage(UIImage(named: imageName[i]), forState: .Normal)
            self.addSubview(btn)
            btn.tag = i
            btn.addTarget(self, action: #selector(SelfSportTabBar.SportTabbarAction(_:)), forControlEvents: .TouchUpInside)

        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetRGBStrokeColor(context, 231/255, 231/255, 231/255, 231/255)
        
        for i in 0 ..< 3 {
            CGContextMoveToPoint(context, CGFloat(i) * rect.size.width / 3, rect.size.height * 0.1)
            CGContextAddLineToPoint(context, CGFloat(i) * rect.size.width / 3, rect.size.height * 0.9)
            
            
        }
        
        CGContextMoveToPoint(context, 8, 0)
        CGContextAddLineToPoint(context, rect.size.width - 8, 0)
        CGContextStrokePath(context)
        
    }
    /**
     *  SelfSportTabBarDelegate
     */
    
    func SportTabbarAction(btn:UIButton){
        switch btn.tag {
        case 0:
            delegate?.comment()
            break
        case 1:
            delegate?.commentController()
            break
        case 2:
            delegate?.likeSport(btn)
            break
        default:
            break
        }
    }

}
