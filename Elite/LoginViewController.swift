//
//  LoginViewController.swift
//  Elite
//
//  Created by Jerry on 16/4/9.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
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
    

    @IBAction func LoginButton(sender: AnyObject) {
        AVUser.logInWithUsernameInBackground(self.userName.text, password: self.password.text) { (user, error) in
            if error == nil{
                self.dismissViewControllerAnimated(true, completion: { 
                    
                })
                print(user.username)
            }else{
                if error.code == 210{
                    ProgressHUD.showError("用户名或密码错误")
                }else if error.code == 211 {
                    ProgressHUD.showError("不存在该用户")
                }else if error.code == 216 {
                    ProgressHUD.showError("未验证邮箱")
                }else if error.code == 1{
                    ProgressHUD.showError("登录失败次数超过限制，账号被锁定，请稍候再试")
                }else if error.code == 217{
                    ProgressHUD.showError("无效的用户名，不允许空白用户名。")
                }else if error.code == 218{
                    ProgressHUD.showError("无效的密码，不允许空白密码。")
                }
                    
                else{
                    ProgressHUD.showError("登录失败")
                }
            }
            //print(user.username)
        }
        
    }
    
    //注册键盘出现和消失
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) {
            self.topLayout.constant = 41
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { 
            self.topLayout.constant = -100
            self.view.layoutIfNeeded()
        }
    }

}
