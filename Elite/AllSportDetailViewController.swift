//
//  AllSportDetailViewController.swift
//  Elite
//
//  Created by Jerry on 16/4/20.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class AllSportDetailViewController: UIViewController ,AllSportTabBarDelegate,InputViewDelegate,HZPhotoBrowserDelegate{
    
    var AllSportDetail:AVObject?
    
    var SportDetailView:AllSportDetailView?
    
    var AllSportViewTabbar:AllSportTabBar?
    
    var AllSportTextView:UITextView?
    
    var input:InputView?
    
    var layView:UIView?
    
    var keyBoardHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.initSportDetailView()
        self.AllSportViewTabbar = AllSportTabBar(frame: CGRectMake(0,SCREEN_HIGHT - 40,SCREEN_WIDTH,40))
        self.view.addSubview(self.AllSportViewTabbar!)
        self.AllSportViewTabbar?.delegate = self
        
        self.AllSportTextView = UITextView(frame: CGRectMake(0,64+SCREEN_HIGHT/4,SCREEN_WIDTH,SCREEN_HIGHT - 64 - SCREEN_HIGHT/4-40))
        self.AllSportTextView?.editable = false
        self.AllSportTextView?.text = AllSportDetail!["SportsDesicription"] as? String
        self.view.addSubview(self.AllSportTextView!)
        self.islike()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     点赞初始化
     */
    func islike(){
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("SportObject", equalTo: self.AllSportDetail)
        query.findObjectsInBackgroundWithBlock { (results, error) in
            if results != nil && results.count != 0 {
                let btn = self.AllSportViewTabbar?.viewWithTag(2) as? UIButton
                btn?.setImage(UIImage(named: "solidheart"), forState: .Normal)
                
            }
        }
    }
    
    
    /**
     *  初始化
     */

    func initSportDetailView(){
        self.SportDetailView = AllSportDetailView(frame: CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HIGHT / 4))
        self.view.addSubview(self.SportDetailView!)
        
        let coverFile = self.AllSportDetail!["SportPhoto"] as? AVFile
        self.SportDetailView?.cover!.sd_setImageWithURL(NSURL(string:(coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        self.SportDetailView?.SportTime?.text = "E时间：" + (self.AllSportDetail!["SportTime"] as? String)!
        self.SportDetailView?.SportPlace?.text = "E地点:" + (self.AllSportDetail!["SportPlace"] as? String)!
        self.SportDetailView?.SportTitle?.text = self.AllSportDetail!["Sport_Title"] as? String
        self.SportDetailView?.EditorName?.text = "来自于:" + (self.AllSportDetail!["EditorName"] as? String)!

        let scanNumber = self.AllSportDetail!["scanNumber"] as? NSNumber
        let loveNumber = self.AllSportDetail!["loveNumber"] as? NSNumber
        let discussNumber = self.AllSportDetail!["discussNumber"] as? NSNumber
        
        if scanNumber != nil && loveNumber != nil && discussNumber != nil
        {
        self.SportDetailView?.More?.text = (loveNumber?.stringValue)!+"个喜欢."+(discussNumber?.stringValue)!+"次评论."+(scanNumber?.stringValue)!+"次浏览"
            
            self.AllSportDetail?.incrementKey("scanNumber")
            self.AllSportDetail?.saveInBackground()
        }else{
            self.SportDetailView?.More?.text = "65个喜欢.5次评论.12次浏览"
        }

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AllSportDetailViewController.photoBrowser as (AllSportDetailViewController) -> () -> ()))
        self.SportDetailView?.cover?.addGestureRecognizer(tap)
        self.SportDetailView?.cover?.userInteractionEnabled = true
        
    }
    
    /**
     InputViewDelegate
     */
    
    func publishButtonDidClick(button: UIButton!) {
        if self.input?.inputTextView.text == ""{
            ProgressHUD.showError("评论不能为空")
        }else{
            ProgressHUD.show("小E正在火速发送中~")
            
            let object = AVObject(className: "discuss")
            object.setObject(self.input?.inputTextView?.text, forKey: "text")
            object.setObject(AVUser.currentUser(), forKey: "user")
            object.setObject(self.AllSportDetail, forKey: "SportObject")
            object.saveInBackgroundWithBlock { (success, error) -> Void in
                if success {
                    self.input?.inputTextView?.resignFirstResponder()
                    ProgressHUD.showSuccess("评论成功")
                    self.input?.inputTextView.text = ""
                    self.AllSportDetail?.incrementKey("discussNumber")
                    self.AllSportDetail?.saveInBackground()
                }else{
                    
                    ProgressHUD.showError("出现问题，评论失败")
                }
            }
        }
    }
    
    func textViewHeightDidChange(height: CGFloat) {
        self.input?.height = height+10
        self.input?.bottom = SCREEN_HIGHT - self.keyBoardHeight
    }
    func keyboardWillHide(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.input?.bottom = SCREEN_HIGHT+(self.input?.height)!
            self.layView?.alpha = 0
        }) { (finish) -> Void in
            
            self.layView?.hidden = true
            
        }
        
    }
    func keyboardWillShow(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.input?.bottom = SCREEN_HIGHT - keyboardHeight
            self.layView?.alpha = 0.2
        }) { (finish) -> Void in
            
        }
    }

    
    /**
     *  AllSportTabBarDelegate
     */
    
    func comment(){
        if self.input == nil {
            self.input = NSBundle.mainBundle().loadNibNamed("InputView", owner: self, options: nil).last as? InputView
            self.input?.frame = CGRectMake(0,SCREEN_HIGHT - 44,SCREEN_WIDTH,44)
            self.input?.delegate = self
            self.view.addSubview(self.input!)
        }
        if self.layView == nil {
            self.layView = UIView(frame: self.view.frame)
            self.layView?.backgroundColor = UIColor.grayColor()
            self.layView?.alpha = 0
            let tap = UITapGestureRecognizer(target: self, action: #selector(SelfSportDetailViewController.tapInputView))
            self.layView?.addGestureRecognizer(tap)
            
        }
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
        self.layView?.hidden = false
        self.input?.inputTextView?.becomeFirstResponder()

    }
    
    func tapInputView(){
        self.input?.inputTextView?.resignFirstResponder()
    }
    
    func commentController(){
        let vc = AllCommentViewController()
        GeneralFactory.addTitleWith(vc, title1: "", title2: "关闭")
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn2?.setTitleColor(MAIN_RED, forState: .Normal)
        vc.SportObject = self.AllSportDetail
        vc.tableView?.mj_header.beginRefreshing()
        self.presentViewController(vc, animated: true) {
            
        }
    }
    func likeSport(btn:UIButton){
        btn.enabled = false
        btn.setImage(UIImage(named: "redheart"), forState: .Normal)
        
        
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("SportObject", equalTo: self.AllSportDetail)
        query.findObjectsInBackgroundWithBlock { (results, error) in
            if results != nil && results.count != 0 { ///取消赞
                for var object in results {
                    object = (object as? AVObject)!
                    object.deleteEventually()
                    
                }
                btn.setImage(UIImage(named: "heart"), forState: .Normal)
                
                self.AllSportDetail?.incrementKey("loveNumber", byAmount: NSNumber(int: -1))
                self.AllSportDetail?.saveInBackground()
                
            }else{// 点赞
                let object = AVObject(className: "Love")
                object.setObject(AVUser.currentUser(), forKey: "user")
                object.setObject(self.AllSportDetail, forKey: "SportObject")
                object.saveInBackgroundWithBlock({ (successed, error) in
                    if successed {
                        btn.setImage(UIImage(named: "solidheart"), forState: .Normal)
                        self.AllSportDetail?.incrementKey("loveNumber", byAmount: NSNumber(int: 1 ))
                        self.AllSportDetail?.saveInBackground()
                    }else{
                        ProgressHUD.showError("当前网络连接不畅")
                        
                    }
                })
            }
            
            btn.enabled = true
            
        }
        
    }
    
    /**
     *  PhotoBrowser
     */
    
    func photoBrowser(){
        let photoBrowser = HZPhotoBrowser()
        photoBrowser.imageCount = 1
        photoBrowser.currentImageIndex = 0
        photoBrowser.delegate = self
        photoBrowser.show()
        
    }
    func photoBrowser(browser: HZPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return self.SportDetailView?.cover?.image
    }
    func photoBrowser(browser: HZPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        let coverFile = self.AllSportDetail!["SportPhoto"] as? AVFile
        return NSURL(string: coverFile!.url)
    }
    
}



