//
//  PushUserinfo.swift
//  Elite
//
//  Created by Jerry on 16/4/25.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class PushUserinfo: NSObject {
    
    static func pushUserinfoInBack(dict:NSDictionary){
        ProgressHUD.show("小E快马加鞭传信去~")
        let object = AVObject(outDataWithClassName: "_User", objectId: AVUser.currentUser().objectId)
        object.setObject(dict["EditorName"], forKey: "EditorName")
        let image = dict["UserCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!))
        
        coverFile.saveInBackgroundWithBlock { (successed, error) in
            if successed{
                object.setObject(coverFile, forKey: "UserCover")
                object.saveInBackgroundWithBlock { (successed, error) in
                    if successed {
                        ProgressHUD.showSuccess("更新成功")
                    }else{
                        print(error)
                        
                    }
                }
            }else{
                print(error)
                
            }
        }
        
    
        
        
        
    }

}
