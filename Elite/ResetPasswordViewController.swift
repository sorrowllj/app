//
//  ResetPasswordViewController.swift
//  Elite
//
//  Created by Jerry on 16/5/30.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit
import Foundation

struct MyRegex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern,
                                         options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matchesInString(input,
                                                options: [],
                                                range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    


    @IBAction func ResetPassWord(sender: UIButton) {
        
        let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let matcher = MyRegex(mailPattern)
        let maybeMailAddress = self.emailAddress.text
        if matcher.match(maybeMailAddress!) {
            print("邮箱地址格式正确")
        }else{
            print("邮箱地址格式有误")
        }
        
        if self.emailAddress.text == ""{
            ProgressHUD.showError("邮箱不能为空")
            
        }else if matcher.match(maybeMailAddress!) == false{
            ProgressHUD.showError("邮箱格式有误")
        }else{
            AVUser.requestPasswordResetForEmailInBackground(self.emailAddress.text, block: { (success, error) in
                if success {
                    ProgressHUD.showSuccess("邮件已发送")
                    self.dismissViewControllerAnimated(true, completion: { 
                        
                    })
                }else if error.code == 205{
                    ProgressHUD.showError("找不到电子邮箱地址对应的用户")
                }else if error.code == 204{
                    ProgressHUD.showError("没有提供电子邮箱地址")
                    
                }else{
                    ProgressHUD.showError("发送失败，请重试")
                }
            })
        }
        
    }
    @IBAction func close(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
}
