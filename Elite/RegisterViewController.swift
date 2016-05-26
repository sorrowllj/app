//
//  RegisterViewController.swift
//  Elite
//
//  Created by Jerry on 16/4/9.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var emaliAddress: UITextField!
    
    @IBOutlet weak var topLaout: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func regiserButton(sender: AnyObject) {
        let user = AVUser()
        user.username = self.userName.text
        user.password = self.passWord.text
        user.email = self.emaliAddress.text
        
        user.signUpInBackgroundWithBlock { (succeeded, error) in
            if(succeeded){
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismissViewControllerAnimated(true, completion: { 
                    
                })
            }else{
                if error.code == 125 {
                    ProgressHUD.showError("邮箱不合法")
                }else if error.code == 203 {
                    ProgressHUD.showError("该邮箱已注册")
                }else if error.code == 202 {
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
            }
        }
    }

    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) {
            self.topLaout.constant = 8
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) {
            self.topLaout.constant = -100
            self.view.layoutIfNeeded()
        }
    }


}
