//
//  Push_TitleController.swift
//  Elite
//
//  Created by Jerry on 16/3/18.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit


typealias Push_TitleCallBack = (Title:String)->Void

class Push_TitleController: UIViewController {

    var textField:UITextField?
    
    var callBack:Push_TitleCallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.textField = UITextField(frame: CGRectMake(15,60,SCREEN_WIDTH - 30, 40))
        self.textField?.borderStyle = .RoundedRect
        self.textField?.placeholder = "一个幽默的标题，会吸引妹纸哦😜"
        self.textField?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.textField!)
        self.textField?.becomeFirstResponder()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func open(){
        self.callBack?(Title:self.textField!.text!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            
        }
        
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}
