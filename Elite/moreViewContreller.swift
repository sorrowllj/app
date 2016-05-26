//
//  moreViewContreller.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class moreViewContreller: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    var alert:UIAlertController?
    
    var addlogoutBotton:UIButton!
    
    var tableView:UITableView?
    
    var username:String!
    
    var usernametest:String!
    
    var userEmail:String!
        
    var navigationView:UIView?

    var userObject:AVObject?
    
    var dataArrays = NSMutableArray()
    
    var nsdataArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.FooterRefresh()
        self.view.backgroundColor = RGB(241, g: 242, b: 248)
        self.setNavigationBar()
        //self.setLogoutBotton()

        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(MoreTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        self.setBasic()
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(moreViewContreller.HeaderRefresh))
        self.tableView?.mj_header.beginRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
//        let dicts = self.nsdataArray[0] as? AVObject
//        username = (dicts!["EditorName"] as? String)
        
        username = AVUser.currentUser().username
        userEmail = AVUser.currentUser().email
        tableView?.reloadData()
        self.navigationView!.hidden = false
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationView!.hidden = true
    }
    

    
    func setBasic(){
        
//        let dicts = self.nsdataArray[0] as? AVObject
//        username = (dicts!["EditorName"] as? String)
        username = AVUser.currentUser().username
        userEmail = AVUser.currentUser().email

    }
    func setNavigationBar(){
        navigationView  = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2,20,SCREEN_WIDTH,45))
        label.adjustsFontSizeToFitWidth = true;
        label.font = UIFont(name: MY_FONT, size: 20)
        label.text = "我"
        label.textColor = UIColor.blackColor()
        
        navigationView!.addSubview(label)
        
        
        
    }
    func setLogoutBotton(){
        addlogoutBotton  = UIButton(frame: CGRectMake(0, 400,SCREEN_WIDTH ,45))
        addlogoutBotton.backgroundColor = UIColor.whiteColor()
        addlogoutBotton.setTitle("退出登录", forState: .Normal)
        addlogoutBotton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addlogoutBotton.titleLabel?.font = UIFont(name: MY_FONT, size: 20)
        addlogoutBotton.contentHorizontalAlignment = .Center
        addlogoutBotton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addlogoutBotton.addTarget(self, action: #selector(moreViewContreller.LogOut), forControlEvents: .TouchUpInside )
        self.view.addSubview(addlogoutBotton)
    }
    
    func LogOut(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: "退出后不会删除任何历史数据，下次登录照常使用。", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "退出登录", style: .Default) { action -> Void in
            self.confirm()
            
        }
        actionSheetController.addAction(takePictureAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    
    }
    
    func confirm(){
        AVUser.logOut()
        tableView?.reloadData()
        if AVUser.currentUser() == nil {
            let story = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = story.instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
                
            })
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }else if indexPath.row == 1 {
            return 20
        }else if indexPath.row == 2{
            return 44
        }
        else if indexPath.row == 3{
            return 44
        }
        return 44
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? MoreTableViewCell
        
        if(indexPath.row == 2 ){
            cell!.accessoryType = .DisclosureIndicator
        }
        if indexPath.row == 3{
            cell?.accessoryType = .DisclosureIndicator
        }
        
//        let dict  = self.dataArrays[0] as? AVObject
//        let coverFile = dict!["UserCover"] as? AVFile
       
        switch indexPath.row {
        case 0:
            let dict  = self.nsdataArray[0] as? AVObject
            let coverFile = dict!["UserCover"] as? AVFile
            if coverFile == nil{
                cell?.UserPhoto?.image = UIImage(named: "Avatar")
            }
            else{
                cell?.UserPhoto?.sd_setImageWithURL(NSURL(string:(coverFile?.url)!), placeholderImage: UIImage(named: "Avatar"))
                print("aa")
            }
            //cell?.UserPhoto?.image = UIImage(named: "Avatar")
            cell?.UserName?.text = "用户名：" + username
            cell?.UserEmail?.text = "邮箱: " + userEmail
            
            break
        case 1:
            cell?.backgroundColor = RGB(241, g: 242, b: 248)
            cell?.selectionStyle = .None
            
            break
        case 2:
            cell?.textLabel?.text = " 手机信息"
            cell?.textLabel?.font = UIFont(name: MY_FONT, size: 16)
            
            
            break
        case 3:
            cell?.textLabel?.text = " 反馈意见"
            cell?.textLabel?.font = UIFont(name: MY_FONT, size: 16)
            
            break
        case 4:
            cell?.textLabel?.text = "退出登录"
            cell?.textLabel?.font = UIFont(name: MY_FONT, size: 20)
            cell?.textLabel?.textAlignment = .Center
            break
            
        default:
            break
        }
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let vc = UserinfoViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            break
        case 2:
            let vc = changePhoneViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = LCUserFeedbackAgent()
            vc.showConversations(self, title:nil, contact: AVUser.currentUser().email)
            
            break
        case 4:
            self.LogOut()
            break
        default:
            break
        }
    }
    
    /**
     *  手机信息
     */
    
    func changePhone(){
        let vc = changePhoneViewController()
        GeneralFactory.addTitleWith(vc)
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        //let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(MAIN_RED, forState: .Normal)
        //btn2?.setTitleColor(MAIN_RED, forState: .Normal)
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
    

    
    func FooterRefresh(){
        let query = AVQuery(className: "_User")
        query.whereKey("objectId", equalTo: AVUser.currentUser().objectId)
        let dict = query.findObjects()
        self.nsdataArray = dict

        print(dict)

       
    }
    
    /**
     *  HeaderRefresh 上拉加载
     */
    func HeaderRefresh(){
        
//        let query = AVQuery(className: "_User")
//        query.whereKey("objectId", equalTo: AVUser.currentUser().objectId)
//        
//        query.findObjectsInBackgroundWithBlock { (result, error) in
        
//
//            self.dataArrays.removeAllObjects()
//            self.dataArrays.addObjectsFromArray(result)
            self.tableView?.reloadData()
        self.tableView?.mj_header.endRefreshing()
//            print(self.dataArrays.count)
//        }
        
        
        
        
        
    }
 


    
    

    

}
