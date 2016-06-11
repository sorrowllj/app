//
//  PushSports.swift
//  Elite
//
//  Created by Jerry on 16/4/14.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class PushSports: NSObject {
    
    static func pushSportInBack(dict:NSDictionary){
    
        ProgressHUD.show("小E快马加鞭传信去~")
        let object = AVObject(className: "Sport")
        object.setObject(dict["SportTime"], forKey: "SportTime")
        object.setObject(dict["SportPlace"], forKey: "SportPlace")
        object.setObject(dict["Sport_Title"], forKey: "Sport_Title")
        object.setObject(dict["type"], forKey: "Type")
        object.setObject(dict["detailType"], forKey: "DetailType")
        object.setObject(dict["SportsDesicription"], forKey: "SportsDesicription")
        object.setObject(AVUser.currentUser(), forKey: "Users")                 //上传用户信息
        object.setObject(dict["EditorName"], forKey: "EditorName")              //用户名
        
        let image = dict["SportPhoto"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!))
        
        coverFile.saveInBackgroundWithBlock({ (successed, error) in
            if (successed){
                object.setObject(coverFile, forKey: "SportPhoto")
                object.saveInBackgroundWithBlock({ (successed, erroe) in
                    if successed {
                        NSNotificationCenter.defaultCenter().postNotificationName("pushSportNotification", object: nil, userInfo: ["success":"true"])
                        print("success")
                        
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("pushSportNotification", object: nil, userInfo: ["success":"false"])
                    }
                })
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("pushSportNotification", object: nil, userInfo: ["success":"false"])
            }
        }){ (Ints) in
            let time:Int  = Ints
            let xNSNumber = time as NSNumber
            let xString : String = xNSNumber.stringValue
            ProgressHUD.show(xString)
            print(xString)
        }
       
        
    }

}
