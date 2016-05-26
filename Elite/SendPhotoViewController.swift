//
//  SendPhotoViewController.swift
//  Elite
//
//  Created by Jerry on 16/5/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class SendPhotoViewController: UIViewController,PhotoTieleDelegate,PhotoPickerDelegate,VPImageCropperDelegate{
    
    var PhotoTitle:SendPhotoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
//        self.PhotoTitle = SendPhotoView(frame: CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HIGHT - 20))
        self.PhotoTitle = SendPhotoView(frame: self.view.frame)
        self.PhotoTitle?.delegate = self
        self.view.addSubview(PhotoTitle!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SendPhotoViewController.pushPhotoNotification), name: "pushPhotoNotification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    //pushPhotoNotification 方法
    
    func pushPhotoNotification(notification:NSNotification){
        let dict = notification.userInfo
        //print(dict!["success"])
        if String(dict!["success"]!) == "true" {
            ProgressHUD.showSuccess("上传成功")
            self.dismissViewControllerAnimated(true, completion: {
                
            })
        }else{
            ProgressHUD.showError("上传失败")
            
        }
        
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func open(){
        let dict = [
            "Comment":(self.PhotoTitle?.textView?.text)!,
            "Photo":(self.PhotoTitle?.SportPlacePhoto?.currentImage)!,
        ]
        
        SendToBack.pushPhotoInBack(dict)
       
    }
    
    func choicePhoto() {
        let vc = PhotoPickerViewController()
        vc .delegate = self
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
        
    }
    
    func getImageFromPicker(image: UIImage) {
        
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
        self.PhotoTitle?.SportPlacePhoto?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    

    


}
