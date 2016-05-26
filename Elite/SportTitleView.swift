//
//  SportTitleView.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

@objc protocol SportTieleDelegate{
    optional func choicePhoto()
}

class SportTitleView: UIView {

    var SportPhoto:UIButton?
    var SportTime:JVFloatLabeledTextField?
    var SportPlace:JVFloatLabeledTextField?
    weak var delegate:SportTieleDelegate?
    var label:UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.stringFromDate(nowDate)
        
        self.SportPhoto = UIButton(frame: CGRectMake(10,8+40,110,114))
        self.SportPhoto?.setImage(UIImage(named: "Cover"), forState: .Normal)
        self.addSubview(self.SportPhoto!)
        self.SportPhoto?.addTarget(self, action: #selector(SportTieleDelegate.choicePhoto), forControlEvents: .TouchUpInside)
        
        
        self.SportTime = JVFloatLabeledTextField(frame: CGRectMake(128,8+40,SCREEN_WIDTH-128-15,30))
        self.SportPlace = JVFloatLabeledTextField(frame: CGRectMake(128,8+70+50,SCREEN_WIDTH-128-15,30))
        self.label = UILabel(frame: CGRectMake(128,8 + 40 + 30,SCREEN_WIDTH-128-15,30))
        self.label?.text = "时间格式:" + dateString
        self.SportTime?.placeholder = "进行运动的时间:"
        self.SportPlace?.placeholder = "进行运动的地点："
        
        self.SportTime?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        self.SportPlace?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        self.label?.font = UIFont(name: MY_FONT, size: 12)
        self.label?.textColor = UIColor.grayColor()
        
        
        self.SportTime?.font = UIFont(name: MY_FONT, size: 14)
        self.SportPlace?.font = UIFont(name: MY_FONT, size: 14)
        
        self.addSubview(self.SportPlace!)
        self.addSubview(self.SportTime!)
        self.addSubview(self.label!)
        
        
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }
    
    func choicePhoto(){
        self.delegate?.choicePhoto!()
    }
    

}
