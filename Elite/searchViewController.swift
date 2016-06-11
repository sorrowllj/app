//
//  searchViewController.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class searchViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    var navigationView:UIView!
    
    var tableView:UITableView?
    
    var dataArrays = NSMutableArray()
    
    var photoObject:AVObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = selfsetColor
        self.setNavigationBar()
        /**
         tableView init
         */
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(PhotoTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pushViewController.HeaderRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pushViewController.FooterRefresh))
        
        self.tableView?.mj_header.beginRefreshing()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setNavigationBar(){
        
        navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        self.navigationController?.navigationBar.addSubview(navigationView!)
        let addSportsBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addSportsBtn.setImage(UIImage(named: "plus circle"), forState: .Normal)
        addSportsBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addSportsBtn.setTitle("          球场风采", forState: .Normal)
        addSportsBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 20)
        addSportsBtn.contentHorizontalAlignment = .Left
        
        addSportsBtn.addTarget(self, action: #selector(searchViewController.pushNewSports), forControlEvents: .TouchUpInside)
        navigationView!.addSubview(addSportsBtn)
        
        
    }
    
    func pushNewSports(){
        let vc = SendPhotoViewController()
        GeneralFactory.addTitleWith(vc, title1: "关闭", title2: "发送")
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(MAIN_RED, forState: .Normal)
        btn2?.setTitleColor(MAIN_RED, forState: .Normal)
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
    
    /**
     *  实现tableview UItableviewdelegate UItableviewdatasoure
     */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrays.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SCREEN_WIDTH + 80
    }
//    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? PhotoTableViewCell
        cell?.selectionStyle = .None
        let dict = self.dataArrays[indexPath.row] as? AVObject
        photoObject = dict
        
        let user = dict!["Users"] as? AVUser
        cell?.editorName?.text = user?.username
        
        let cover = user?.objectForKey("UserCover") as? AVFile
        if cover == nil{
            cell?.touxiang?.image = UIImage(named: "Avatar")
        }else{
            let file = AVFile(URL: cover?.url)
            file.getThumbnail(true, width: 150 , height: 280, withBlock: { (images, error) in
                cell?.touxiang?.image = images
                
                
            })
            //cell?.touxiang?.sd_setImageWithURL(NSURL(string:(cover?.url)!), placeholderImage: UIImage(named: "Avatar"))
        }
        //cell?.touxiang?.image = UIImage(named: "Avatar")
        
        let date = dict!["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell?.sendtime?.text = format.stringFromDate(date!)

        cell?.texifield?.text = (dict!["Comment"] as? String)
        
        
        
        let coverFile2 = dict!["Photo"] as? AVFile
        if coverFile2 == nil{
            cell?.photo?.image = UIImage(named: "Cover")
        }else{
        cell?.photo?.sd_setImageWithURL(NSURL(string:(coverFile2?.url)!), placeholderImage: UIImage(named: "Cover"))
        }
        

        
        
        return cell!
        
    }

    
    
    
    /**
     *  HeaderRefresh 上拉加载
     */
    func HeaderRefresh(){
        
        let query = AVQuery(className: "SportPhoto")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        //query.whereKey("Users", equalTo: AVUser.currentUser())    //主键
        query.includeKey("Users")
        query.findObjectsInBackgroundWithBlock { (result, error) in
            self.tableView?.mj_header.endRefreshing()
            
            if error != nil{
            
            }else{
            self.dataArrays.removeAllObjects()
            self.dataArrays.addObjectsFromArray(result)
            self.tableView?.reloadData()
            }
        }
        
    }
    /**
     下拉刷新
     */
    func FooterRefresh(){
        
        let query = AVQuery(className: "SportPhoto")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArrays.count
        //query.whereKey("Users", equalTo: AVUser.currentUser())    //主键
        query.includeKey("Users")
        query.findObjectsInBackgroundWithBlock { (result, error) in
            self.tableView?.mj_footer.endRefreshing()
            if error != nil{
            
            }else{
                self.dataArrays.addObjectsFromArray(result)
                self.tableView?.reloadData()
            }

        }
        
    }
    

    
    

}
