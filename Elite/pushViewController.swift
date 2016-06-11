//
//  pushViewController.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

class pushViewController: UIViewController , UITableViewDelegate, UITableViewDataSource ,SWTableViewCellDelegate{
    
    var dataArray = NSMutableArray()
    
    var tableView:UITableView?
    
    var navigationView:UIView!

    var swipIndexPath:NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(241, g: 242, b: 248)
        
        self.setNavigationBar()
        /**
         设置tableview
         */
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(pushSportsCell.classForCoder(), forCellReuseIdentifier: "cell")
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
        self.HeaderRefresh()
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationView.hidden = true
    }
    
    
    func setNavigationBar(){
    
        navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        
        //navigationView.backgroundColor = UIColor.grayColor()
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
        let addSportsBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addSportsBtn.setImage(UIImage(named: "plus circle"), forState: .Normal)
        addSportsBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addSportsBtn.setTitle("          我的运动", forState: .Normal)
        addSportsBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 20)
        addSportsBtn.contentHorizontalAlignment = .Left
        
        addSportsBtn.addTarget(self, action: #selector(pushViewController.pushNewSports), forControlEvents: .TouchUpInside)
        navigationView!.addSubview(addSportsBtn)
        
    
    }

    func pushNewSports(){
        let vc = pushNewSportsViewController()        
        GeneralFactory.addTitleWith(vc, title1: "关闭", title2: "确认")
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
        return self.dataArray.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? pushSportsCell
        
        cell?.rightUtilityButtons = self.returnRightBtn()
        cell?.delegate = self
        
        let dict = self.dataArray[indexPath.row] as? AVObject
        
        cell?.SportTime?.text = "E时间：" + (dict!["SportTime"] as? String)!
        
        cell?.SportPlace?.text = "E地点：" + (dict!["SportPlace"] as? String)!
        
        let date = dict!["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell?.More?.text =  "来自于：" + (dict!["EditorName"] as? String)!
        
        cell?.sendTime?.text = format.stringFromDate(date!)
        
        cell?.SportTitle?.text = dict!["Sport_Title"] as? String 
        
        
        let coverFile = dict!["SportPhoto"] as? AVFile
        if coverFile == nil {
            cell?.cover?.image = UIImage(named: "Cover")
        }else{
            let file = AVFile(URL: coverFile?.url)
            file.getThumbnail(true, width: 150 , height: 280, withBlock: { (images, error) in
                cell?.cover?.image = images
                
                
            })
            //cell?.cover?.sd_setImageWithURL(NSURL(string:(coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
            
            
        }
        //cell?.cover?.sd_setImageWithURL(NSURL(string:(coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
        
    }
    
    
    func returnRightBtn()->[AnyObject]{
    
        
        let btn2 = UIButton(frame:CGRectMake(0,0,88,88))
        btn2.backgroundColor = UIColor.redColor()
        btn2.setTitle("删除", forState: .Normal)
        
        return [btn2]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = SelfSportDetailViewController()
        vc.SelfSportDetail = dataArray[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    /**
     SWTableViewCellDelegate
     */
    func swipeableTableViewCell(cell: SWTableViewCell!, scrollingToState state: SWCellState) {
        let indexPath = self.tableView?.indexPathForCell(cell)
        if state == .CellStateRight{
            if self.swipIndexPath != nil && self.swipIndexPath?.row != indexPath?.row {
                let swipedCell = self.tableView?.cellForRowAtIndexPath(self.swipIndexPath!) as? pushSportsCell
                swipedCell?.hideUtilityButtonsAnimated(true)
            }
            self.swipIndexPath = indexPath
        }else if state == .CellStateCenter{
            self.swipIndexPath = nil
        }
    }
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        cell.hideUtilityButtonsAnimated(true)
        
        let indexPath = self.tableView?.indexPathForCell(cell)
        let object = self.dataArray[(indexPath?.row)!] as? AVObject
        
        if index == 0 { //删除
            ProgressHUD.show("")
            
            let discussQuery = AVQuery(className: "discuss")
            discussQuery.whereKey("SportObject", equalTo: object)
            discussQuery.findObjectsInBackgroundWithBlock({ (results, error) in
                
                for Sport in results {
                    let sportObject = Sport as? AVObject
                    sportObject?.deleteInBackground()
                }
            })
            
            let LoveQuery = AVQuery(className: "Love")
            LoveQuery.whereKey("SportObject", equalTo: object)
            LoveQuery.findObjectsInBackgroundWithBlock({ (results, error) in
                
                for Sport in results {
                    let sportObject = Sport as? AVObject
                    sportObject?.deleteInBackground()
                }
            })
            
            object?.deleteInBackgroundWithBlock({ (success, error) in
                if success {
                    ProgressHUD.showSuccess("删除成功")
                    self.dataArray.removeObjectAtIndex((indexPath?.row)!)
                    self.tableView?.reloadData()
                    
                }else{
                    
                }
            })
            
            
        }
        
    }
    
    
    /**
     *  HeaderRefresh 上拉加载
     */
    func HeaderRefresh(){
        
        let query = AVQuery(className: "Sport")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("Users", equalTo: AVUser.currentUser())    //主键
        
        query.findObjectsInBackgroundWithBlock { (result, error) in
            self.tableView?.mj_header.endRefreshing()
            if error != nil{
                
            }else{
                
                self.dataArray.removeAllObjects()
                self.dataArray.addObjectsFromArray(result)
                self.tableView?.reloadData()
            }

        }
        
    
    }
    
    
    /**
     下拉刷新
     */
    func FooterRefresh(){
        
        let query = AVQuery(className: "Sport")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("Users", equalTo: AVUser.currentUser())    //主键
        
        query.findObjectsInBackgroundWithBlock { (result, error) in
            self.tableView?.mj_footer.endRefreshing()
            if error != nil{
            
            }else{
                self.dataArray.addObjectsFromArray(result)
                self.tableView?.reloadData()
            }

        }
        
    }
    
 
    
    
    
    
  
    
    
    
    
}
