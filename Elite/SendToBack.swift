//
//  SendToBack.swift
//  Elite
//
//  Created by Jerry on 16/5/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class SendToBack: NSObject {

    
    static func pushPhotoInBack(dict:NSDictionary){
        ProgressHUD.show("小E快马加鞭传信去~")
        let object = AVObject(className: "SportPhoto")
        object.setObject(dict["Comment"], forKey: "Comment")
        object.setObject(AVUser.currentUser(), forKey: "Users")
        
        let image = dict["Photo"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!))

        coverFile.saveInBackgroundWithBlock { (successed, error) in
            if successed {
                object.setObject(coverFile, forKey: "Photo")
                object.saveInBackgroundWithBlock({ (successed, error) in
                    if successed {
                        ProgressHUD.showSuccess("上传成功")
                        NSNotificationCenter.defaultCenter().postNotificationName("pushPhotoNotification", object: nil, userInfo: ["success":"true"])
                    }else{
                        ProgressHUD.showError("上传失败，请检查网络")
                        print(error)
                         NSNotificationCenter.defaultCenter().postNotificationName("pushPhotoNotification", object: nil, userInfo: ["success":"false"])
                    }
                })
            }
            else{
                ProgressHUD.showError("上传失败，请检查网络")
                 NSNotificationCenter.defaultCenter().postNotificationName("pushPhotoNotification", object: nil, userInfo: ["success":"false"])
            }
            
        }
        
    }
}
