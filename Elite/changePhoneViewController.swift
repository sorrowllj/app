//
//  changePhoneViewController.swift
//  Elite
//
//  Created by Jerry on 16/4/21.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class changePhoneViewController: UIViewController {
    
    var  PhoneNumber:UITextField?
    
    var PhoneConfirm:UITextField?
    
    var ConfirmBtn:CHWButton?
    
    var SendMessage:UIButton?
    
    var ConfireMessage:UIButton?
    
    var CurrentPhoneLabel:UILabel?
    
    var PhoneNumberString:String?
    
    var dataArray = NSMutableArray()
    
    var PhoneLable:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(241, g: 242, b: 248)
        //print(AVUser.currentUser().mobilePhoneNumber)
        
        if AVUser.currentUser().mobilePhoneVerified == false {
        
        self.CurrentPhoneLabel = UILabel(frame: CGRect(x: 20, y: 70, width: SCREEN_WIDTH - 30, height: 40))
        self.CurrentPhoneLabel?.font = UIFont(name: MY_FONT, size: 15)
        self.CurrentPhoneLabel?.text = "请绑定手机号码："
        self.CurrentPhoneLabel?.textColor = UIColor.blackColor()
        self.view.addSubview(self.CurrentPhoneLabel!)
        
        
        self.PhoneNumber = UITextField(frame: CGRectMake(20,110,SCREEN_WIDTH - 50, 40))
        self.PhoneNumber?.borderStyle = .RoundedRect
        self.PhoneNumber?.placeholder = "输入手机号码"
        self.PhoneNumber?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.PhoneNumber!)
        
        self.PhoneConfirm = UITextField(frame: CGRectMake(20,200,SCREEN_WIDTH / 2, 40))
        self.PhoneConfirm?.borderStyle = .RoundedRect
        self.PhoneConfirm?.placeholder = "输入验证码"
        self.PhoneConfirm?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.PhoneConfirm!)
        
        self.ConfirmBtn = CHWButton(count: 30,frame: CGRectMake(SCREEN_WIDTH / 2 + 30,200,SCREEN_WIDTH / 3, 40), color:nil)
        //self.ConfirmBtn!.backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        self.ConfirmBtn!.animaType = CountBtnType.CHWBtnTypeScale
        self.ConfirmBtn!.layer.masksToBounds = true
        self.ConfirmBtn!.layer.cornerRadius = 10
        //self.ConfirmBtn!.setTitle("获取验证码", forState: .Normal)
        self.ConfirmBtn!.contentHorizontalAlignment = .Center
        self.view.addSubview(self.ConfirmBtn!)
        self.ConfirmBtn!.addTarget(self, action: #selector(changePhoneViewController.ConfirmPhoneNumber), forControlEvents: .TouchUpInside)
        
        self.ConfireMessage = UIButton(frame: CGRectMake(0,400,SCREEN_WIDTH, 40))
        self.ConfireMessage?.backgroundColor = UIColor.whiteColor()
        self.ConfireMessage?.setTitleColor(MAIN_RED, forState: .Normal)
        self.ConfireMessage?.setTitle("确认手机号码", forState: .Normal)
        self.ConfireMessage?.contentHorizontalAlignment = .Center
        self.view.addSubview(self.ConfireMessage!)
        self.ConfireMessage?.addTarget(self, action: #selector(changePhoneViewController.ConfireMessageaction), forControlEvents: .TouchUpInside)
        
        }else{
            self.CurrentPhoneLabel = UILabel(frame: CGRect(x: 20, y: 70, width: SCREEN_WIDTH - 30, height: 40))
            self.CurrentPhoneLabel?.font = UIFont(name: MY_FONT, size: 15)
            
            if AVUser.currentUser().mobilePhoneNumber == ""{
                self.CurrentPhoneLabel?.text = "退出重新登录，显示账号"
            }else{
                self.PhoneLable = UILabel(frame: CGRectMake(0, 100,SCREEN_WIDTH,50))
                //self.PhoneLable?.font = UIFont(name: MY_FONT, size: 20)
                self.PhoneLable?.font = UIFont.systemFontOfSize(20)
                self.PhoneLable?.textColor = UIColor.whiteColor()
                self.PhoneLable?.backgroundColor = buttoncolor
                self.PhoneLable?.textAlignment = .Left
                self.PhoneLable?.text = "  手机号码已验证：" + AVUser.currentUser().mobilePhoneNumber
                self.view.addSubview(self.PhoneLable!)
                
                //self.CurrentPhoneLabel?.text = "手机号码已验证：" + AVUser.currentUser().mobilePhoneNumber
            }
            
            self.CurrentPhoneLabel?.textColor = UIColor.blackColor()
            self.view.addSubview(self.CurrentPhoneLabel!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        self.PhoneNumberString = AVUser.currentUser().mobilePhoneNumber
//        self.view.reloadInputViews()
//    }
    

    
    func open(){
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            
        }
        
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func ConfirmPhoneNumber(){
     
        if self.PhoneNumber?.text == "" {
            ProgressHUD.showError("手机号不能为空")
        }
        else{

        let todo = AVObject(outDataWithClassName: "_User", objectId: AVUser.currentUser().objectId)
        todo.setObject(self.PhoneNumber?.text, forKey: "mobilePhoneNumber")
        
        todo.saveInBackgroundWithBlock { (succeeded, error) in
            if succeeded {
                AVUser .requestMobilePhoneVerify(self.PhoneNumber?.text) { (succeeded, error) in
                    if succeeded {
                        ProgressHUD.showSuccess("短信发送成功")
                    }else{
                        
                    }
                    
                }
            }else if error.code == 211{
                ProgressHUD.showError("找不到用户")
                
            }else if error.code == 213{
                ProgressHUD.showError("手机号码对应的用户不存在")
                
            }
            else if error.code == 214{
                ProgressHUD.showError("手机号码已经被注册")
                
            }else if error.code == 601{
                ProgressHUD.showError("发送短信过快，请稍后重试")
                print(error)
            }
            
        }
        }
    }
    

    
//    func sendMessage(){
//        AVUser .requestMobilePhoneVerify("15757116576") { (succeeded, error) in
//            if succeeded {
//                ProgressHUD.showSuccess("成功")
//            }else{
//                print(error)
//            }
//
//        }
//    }
    
    func ConfireMessageaction(){
        if self.PhoneConfirm?.text == "" {
            ProgressHUD.showError("验证码不能为空")
        }else{
        AVUser .verifyMobilePhone(self.PhoneConfirm?.text) { (succeeded, error) in
            if succeeded {
                ProgressHUD.showSuccess("绑定手机后，需要重新登录账号")
                
                AVUser.logOut()
                if AVUser.currentUser() == nil {
                    let story = UIStoryboard(name: "Login", bundle: nil)
                    let loginVC = story.instantiateViewControllerWithIdentifier("Login")
                    self.presentViewController(loginVC, animated: true, completion: { () -> Void in
                        
                    })
                    
                }
                
            }else{
                ProgressHUD.showError("验证码错误")
                print(error)
            }
        }
        }
        
    }



}
