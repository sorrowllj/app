//
//  rankViewController.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class rankViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    var dataArrays = NSMutableArray()
    
    var tableView:UITableView?
    
    var navigationView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = selfsetColor
        self.setNavigationBar()
        
        if AVUser.currentUser() == nil {
            let story = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = story.instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
                
            })
            
        }
        
        
        
        /**
         设置tableview
         */
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(AllpushSportTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pushViewController.HeaderRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pushViewController.FooterRefresh))
        
        self.tableView?.mj_header.beginRefreshing()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationView.hidden = false
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationView.hidden = true
    }
    
    
    func setNavigationBar(){
        navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        //navigationView.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.addSubview(navigationView)

        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 3,20,SCREEN_WIDTH,45))
        //label.center.x = self.view.bounds.width / 2
        
        //label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true;
        label.font = UIFont(name: MY_FONT, size: 20)
        label.text = "广场上的活动"
        label.textColor = UIColor.blackColor()
        
        navigationView.addSubview(label)
        
    }
    
    
    /**
     *  实现tableview UItableviewdelegate UItableviewdatasoure
     */

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrays.count
        
        //return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? AllpushSportTableViewCell
        
        let dict  = self.dataArrays[indexPath.row] as? AVObject
        cell?.SportTime?.text = "E时间：" + (dict!["SportTime"] as? String)!
        
        cell?.SportPlace?.text = "E地点：" + (dict!["SportPlace"] as? String)!
        
        let date = dict!["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell?.sendTime?.text = format.stringFromDate(date!)
        
        cell?.SportTitle?.text = dict!["Sport_Title"] as? String
        cell?.More?.text =  "来自于：" + (dict!["EditorName"] as? String)!
        
        let coverFile = dict!["SportPhoto"] as? AVFile
        if coverFile == nil {
            cell?.cover?.image = UIImage(named: "Cover")
        }else{
            cell?.cover?.sd_setImageWithURL(NSURL(string:(coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        }
        //cell?.cover?.sd_setImageWithURL(NSURL(string:(coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = AllSportDetailViewController()
        vc.AllSportDetail = dataArrays[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    /**
     *  HeaderRefresh 上拉加载
     */
    func HeaderRefresh(){
        
        let query = AVQuery(className: "Sport")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        //query.whereKey("Users", equalTo: AVUser.currentUser())    //主键
        
        query.findObjectsInBackgroundWithBlock { (result, error) in
            self.tableView?.mj_header.endRefreshing()
            
            self.dataArrays.removeAllObjects()
            self.dataArrays.addObjectsFromArray(result)
            self.tableView?.reloadData()
        }
        
        
    }
    /*
     下拉刷新
     */
    func FooterRefresh(){
        
        let query = AVQuery(className: "Sport")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArrays.count
        //query.whereKey("Users", equalTo: AVUser.currentUser())    //主键
        
        query.findObjectsInBackgroundWithBlock { (result, error) in
            self.tableView?.mj_footer.endRefreshing()
            
            
            self.dataArrays.addObjectsFromArray(result)
            self.tableView?.reloadData()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
