//
//  SendPhotoView.swift
//  Elite
//
//  Created by Jerry on 16/5/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

@objc protocol PhotoTieleDelegate{
    optional func choicePhoto()
}

class SendPhotoView: UIView {

    var textView:JVFloatLabeledTextView?
    
    var SportPlacePhoto:UIButton?

    var delegate:PhotoTieleDelegate?
    
    
    override init(frame: CGRect) {
        
       super.init(frame: frame)
        self.textView = JVFloatLabeledTextView(frame: CGRectMake(10, 50 + 10 + 30, SCREEN_WIDTH - 20 , 100))
        self.addSubview(self.textView!)
        self.textView?.placeholder = " 这一刻的想法..."
        self.textView?.font = UIFont(name: MY_FONT, size: 18)
        self.tintColor = UIColor.grayColor()
        //self.textView?.becomeFirstResponder()
        
        self.SportPlacePhoto = UIButton(frame: CGRectMake(10,160 + 10 + 30,100,100))
        self.SportPlacePhoto?.setImage(UIImage(named: "Cover"), forState: .Normal)
        self.addSubview(self.SportPlacePhoto!)
        SportPlacePhoto?.addTarget(self, action: #selector(SendPhotoView.choicePhoto), forControlEvents: .TouchUpInside )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func choicePhoto(){
        self.delegate?.choicePhoto!()
    }
    


}
