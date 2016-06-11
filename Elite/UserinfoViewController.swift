//
//  UserinfoViewController.swift
//  Elite
//
//  Created by Jerry on 16/4/25.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class UserinfoViewController: UIViewController ,UserinfoDelegate ,PhotoPickerDelegate ,VPImageCropperDelegate{
    
    var userinformation:AVObject?
    
    var usertitle:UserinfoView?
    
    var dict:NSDictionary?
    
    var changeNameBtn:UIButton?
    
    var changeNameBtn2:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(241, g: 242, b: 248)
        //self.setNavigationBar()
        self.navigationItem.title = "个人信息"
        
        self.usertitle = UserinfoView(frame: CGRectMake(0,40,SCREEN_WIDTH,160))
        self.usertitle?.delegate = self
        self.view.addSubview(self.usertitle!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserinfoViewController.pushUserNotification), name: "pushUserNotification", object: nil)
        self.setinit()
        self.setChangeNamebtn()
        
        let coverfile = self.userinformation!["UserCover"] as? AVFile
        if coverfile == nil {
            self.usertitle?.Cover?.setImage(UIImage(named: "Avatar"), forState: .Normal)
        }else{
            let file = AVFile(URL: coverfile?.url)
            file.getThumbnail(true, width: 150 , height: 280, withBlock: { (images, error) in
                 self.usertitle?.Cover?.setImage(images, forState: UIControlState.Normal)
                
                            
            })
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    func setinit(){
        if AVUser.currentUser().mobilePhoneVerified == true{
            dict = [
                "EditorName":AVUser.currentUser().username,
                "Email":AVUser.currentUser().email,
                "PhoneNumber":AVUser.currentUser().mobilePhoneNumber,
                
            ]
        }else{
            dict = [
                "EditorName":AVUser.currentUser().username,
                "Email":AVUser.currentUser().email,
                "PhoneNumber":"请验证手机号码",
            ]
        }
        
        self.usertitle?.Email?.text = " 邮箱地址：" + (dict!["Email"]! as! String)
        self.usertitle?.UserName?.text =  (dict!["EditorName"]! as! String)
        self.usertitle?.PhoneNumber?.text = " 手机号码：" + (dict!["PhoneNumber"]! as! String)
    }

    func pushUserNotification(notification:NSNotification){
        let dict = notification.userInfo
        if String(dict!["success"]!) == "true" {
            ProgressHUD.showSuccess("上传成功")
            self.dismissViewControllerAnimated(true, completion: {
                
            })
        }else{
            ProgressHUD.showError("上传失败")
            
        }
    }
    
    func setChangeNamebtn(){
        changeNameBtn = UIButton(frame: CGRectMake(10,350,SCREEN_WIDTH - 20,30))
        changeNameBtn?.setTitle("更改头像", forState: .Normal)
        changeNameBtn?.backgroundColor = buttoncolor
        changeNameBtn?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changeNameBtn?.addTarget(self, action: #selector(UserinfoViewController.sendNametocloud), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.changeNameBtn!)
    }
    
    func sendNametocloud(){
        let dicts = [
            "EditorName":(self.usertitle?.UserName?.text)!,
            "objectId":AVUser.currentUser().objectId,
            "UserCover":(self.usertitle?.Cover?.currentImage)!,
            
        ]
        PushUserinfo.pushUserinfoInBack(dicts)
        
    }
    




    
    func choicePhoto() {
        let vc = PhotoPickerViewController()
        vc .delegate = self
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
    
    func getImageFromPicker(image: UIImage) {
        //self.SportTiele?.SportPhoto?.setImage(image, forState: .Normal)
        
        let CroVC = VPImageCropperViewController(image: image, cropFrame: CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH*1.273), limitScaleRatio: 3)
        CroVC.delegate = self
        self.presentViewController(CroVC, animated: true) { () -> Void in
            
        }
    }
    
    /**
     VPImageCropperDelegate
     
     */
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.usertitle?.Cover?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    
    
    


}
