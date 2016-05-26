//
//  pushNewSportsViewController.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class pushNewSportsViewController: UIViewController ,SportTieleDelegate,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource{

    
    var SportTiele:SportTitleView?
    
    var tableView:UITableView?
    
    var titleArray:Array<String> = []
    
    var Sport_Title = ""
    
    var type = "分类"
    
    var detailType = "详细"
    
    var SportsDesicription = ""
    
    var EditorName = AVUser.currentUser().username
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.view.backgroundColor = UIColor.whiteColor()
        
        self.SportTiele = SportTitleView(frame: CGRectMake(0,40,SCREEN_WIDTH,160))
        self.SportTiele?.delegate = self
        self.view.addSubview(self.SportTiele!)
        
        
        
        self.tableView = UITableView(frame: CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HIGHT - 200), style: .Grouped)
        
//      使没有内容的表格线条内容消失
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["一个幽默的标题","运动分类","详细内容"]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(pushNewSportsViewController.pushSportNotification), name: "pushSportNotification", object: nil)
        
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    //pushSportNotification 方法
    
    func pushSportNotification(notification:NSNotification){
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
    
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func open(){
        if self.SportTiele?.SportTime?.text == ""{
            ProgressHUD.showError("没有时间，小伙伴怎么起来呢？")
        }else if self.SportTiele?.SportPlace?.text == ""{
            ProgressHUD.showError("地点你忘了输入啊，亲~")
        }else{
        let dict  = [
            "SportTime":(self.SportTiele?.SportTime?.text)!,
            "SportPlace":(self.SportTiele?.SportPlace?.text)!,
            "SportPhoto":(self.SportTiele?.SportPhoto?.currentImage)!,
            
            "Sport_Title":self.Sport_Title,
            "type":self.type,
            "detailType":self.detailType,
            "SportsDesicription":self.SportsDesicription,
            "EditorName":self.EditorName,
            
          
        ]
        
        PushSports.pushSportInBack(dict)
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
        self.SportTiele?.SportPhoto?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    /**
     *  UITableViewDelegate  &&  UITableViewDataSource
     */

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
            
        }
        
        if(indexPath.row < 3){
            cell.accessoryType = .DisclosureIndicator
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        
        
        
        switch indexPath.row{
            case 0 :
                cell.detailTextLabel?.text = self.Sport_Title
                
                break
            case 1:
                
                cell.detailTextLabel?.text = self.type + "->" + self.detailType
                
                break
            case 2:
                let commentView  = UITextView(frame: CGRectMake(4, 50, SCREEN_WIDTH - 8, 150))
                commentView.text = self.SportsDesicription
                commentView.font = UIFont(name: MY_FONT, size: 15)
                commentView.editable = false
                commentView.backgroundColor = RGB(246, g: 246, b: 246)
                commentView.textColor = UIColor.blackColor()
                cell.contentView.addSubview(commentView)
                
                break
            default:
                break
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.tableViewSelectTitle()
            break
        case 1:
            self.tableViewSelectType()
            break
        case 2:
            self.tableViewSelectDescription()
            break
        default:
            break
            
        }
    }
    
//    编写运动的标题
    func tableViewSelectTitle(){
        let vc = Push_TitleController()
        GeneralFactory.addTitleWith(vc)
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(MAIN_RED, forState: .Normal)
        btn2?.setTitleColor(MAIN_RED, forState: .Normal)
        vc.callBack = ({(Title:String) ->Void in
            self.Sport_Title = Title
            self.tableView?.reloadData()
            
        })
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
    
//    选择运动分类
    func tableViewSelectType(){
        let vc = Push_typeController()
        GeneralFactory.addTitleWith(vc)
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        btn2?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        vc.type = self.type
        vc.detailType = self.detailType
        
        vc.callBack = ({(type:String,detailType:String)->Void in
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
            
        })
        
        self.presentViewController(vc, animated: true) { () -> Void in
        }
        
        
    
    }
    
//    详细内容
    
    func tableViewSelectDescription(){
        
        let vc = Push_DescriptionController()
        GeneralFactory.addTitleWith(vc)
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(MAIN_RED, forState: .Normal)
        btn2?.setTitleColor(MAIN_RED, forState: .Normal)
        vc.textView?.text = self.SportsDesicription
        
        vc.callBack = ({(description:String)->Void in
            self.SportsDesicription = description
            
            if self.titleArray.last == ""{
                self.titleArray.removeLast()
            }
//            if description != "" {
//                self.titleArray.append("")
//                
//            }
            self.tableView?.reloadData()
            
        })
        
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    
    }



}
















