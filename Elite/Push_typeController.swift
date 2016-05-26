//
//  Push_typeController.swift
//  Elite
//
//  Created by Jerry on 16/3/18.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

typealias Push_TypeControllerBlock = (type: String,detailType:String)->Void


class Push_typeController: UIViewController ,IGLDropDownMenuDelegate{
    
    var segementController1:AKSegmentedControl?
    var segementController2:AKSegmentedControl?
    
    var dropDownMenu1:IGLDropDownMenu?
    var dropDownMenu2:IGLDropDownMenu?
    
    var type = "球类"
    var detailType = "球类"
    
    var callBack:Push_TypeControllerBlock?
    
    var literatureArray1:Array<NSDictionary> = []
    var literatureArray2:Array<NSDictionary> = []
    
    
    var humanitiesArray1:Array<NSDictionary> = []
    var humanitiesArray2:Array<NSDictionary> = []
    
    
    var livelihoodArray1:Array<NSDictionary> = []
    var livelihoodArray2:Array<NSDictionary> = []
    
    
    var economiesArray1:Array<NSDictionary> = []
    var economiesArray2:Array<NSDictionary> = []
    
    
    var technologyArray1:Array<NSDictionary> = []
    var technologyArray2:Array<NSDictionary> = []
    
    var NetworkArray1:Array<NSDictionary> = []
    var NetworkArray2:Array<NSDictionary> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(231, g: 231, b: 231)
        
        let segementLabel = UILabel(frame: CGRectMake((SCREEN_WIDTH - 300)/2,30,300,20))
        segementLabel.font = UIFont(name: MY_FONT, size: 17)
        segementLabel.text = "请选择运动分类"
        segementLabel.shadowOffset = CGSizeMake(0, 1)
        segementLabel.shadowColor = UIColor.whiteColor()
        segementLabel.textColor = RGB(82, g: 113, b: 131)
        segementLabel.textAlignment = .Center
        self.view.addSubview(segementLabel)
        
        self.initSegement()
        self.initDropArray()
        self.createDropMenu(self.literatureArray1, array2: self.literatureArray2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func open(){
        self.callBack!(type: self.type,detailType: self.detailType)
        self.dismissViewControllerAnimated(true) { 
            
        }
        
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    /**
     init Array
     */
    func initDropArray(){
        
        self.literatureArray1 = [
            ["title":"足球"],
            ["title":"篮球"],
            ["title":"兵乓球"],
            ["title":"木球"],
            ["title":"羽毛球"],
            ["title":"网球"],
        ];
        self.literatureArray2 = [
            ["title":"高尔夫球"],
            ["title":"冰球"],
            ["title":"排球"],
            ["title":"棒球"],
            ["title":"其他"],
        ];
        self.humanitiesArray1 = [
            ["title":"慢跑"],
            ["title":"马拉松"],
            ["title":"跨栏"],
            ["title":"铅球"],
            ["title":"障碍跑"],
            ["title":"接力跑"],
        ];
        self.humanitiesArray2 = [
            ["title":"标枪"],
            ["title":"全能"],
            ["title":"其他"],
        ];
        self.livelihoodArray1 = [
            ["title":"游泳"],
            
        ];
        self.livelihoodArray2 = [
            ["title":"没有更多了"],
            
        ];
        self.economiesArray1  = [
            ["title":"登山"],
            
        ];
        self.economiesArray2  = [
            ["title":"没有更多了"],
        ];
        self.technologyArray1 =  [
            ["title":"健美"],
            
        ];
        self.technologyArray2 = [
            ["title":"没有更多了"],
            
        ];
        self.NetworkArray1 =    [
            ["title":"其他"],
            
        ];
        self.NetworkArray2 =    [
            ["title":"其他"],
            
        ];
        
        
        
        
        
    }
    
    //初始化segement
    
    func initSegement(){
        
        let buttonArray1 = [
            ["image":"ledger","title":"球类","font":MY_FONT],
            ["image":"drama masks","title":"田径","font":MY_FONT],
            ["image":"aperture","title":"游泳","font":MY_FONT],
        ]
        
        self.segementController1 = AKSegmentedControl(frame: CGRectMake(10,60,SCREEN_WIDTH-20,37))
        self.segementController1?.initButtonWithTitleandImage(buttonArray1)
        self.view.addSubview(self.segementController1!)
        
        let buttonArray2 = [
            ["image":"atom","title":"登山","font":MY_FONT],
            ["image":"alien","title":"健美","font":MY_FONT],
            ["image":"fire element","title":"其他","font":MY_FONT],
            ]
        self.segementController2 = AKSegmentedControl(frame: CGRectMake(10,110,SCREEN_WIDTH-20,37))
        self.segementController2?.initButtonWithTitleandImage(buttonArray2)
        self.view.addSubview(self.segementController2!)
        
        self.segementController1?.addTarget(self, action: #selector(Push_typeController.segmentControllerAction(_:)), forControlEvents: .ValueChanged)
        self.segementController2?.addTarget(self, action: #selector(Push_typeController.segmentControllerAction(_:)), forControlEvents: .ValueChanged)
    }

    /**
     *  segment的点击动作
     */
    func segmentControllerAction(segment:AKSegmentedControl){
        var index = segment.selectedIndexes.firstIndex
        
        self.type = ((segment.buttonsArray[index] as? UIButton)?.currentTitle)!
        
        
       // print(index)
        if segment == self.segementController1{
            self.segementController2?.setSelectedIndex(3)
        }else{
            self.segementController1?.setSelectedIndex(3)
            index += 3
            
        }
        
        if self.dropDownMenu1 != nil {
            self.dropDownMenu1?.resetParams()
        }
        if self.dropDownMenu2 != nil {
            self.dropDownMenu2?.resetParams()
        }
        
        switch (index) {
        case 0:
            self.createDropMenu(self.literatureArray1, array2: self.literatureArray2)
            break
        case 1:
            self.createDropMenu(self.humanitiesArray1, array2: self.humanitiesArray2)
            break
        case 2:
            self.createDropMenu(self.livelihoodArray1, array2: self.livelihoodArray2)
            break
        case 3:
            self.createDropMenu(self.economiesArray1, array2: self.economiesArray2)
            break
        case 4:
            self.createDropMenu(self.technologyArray1, array2: self.technologyArray2)
            break
        case 5:
            self.createDropMenu(self.NetworkArray1, array2: self.NetworkArray2)
            break
        default:
            break
        }
        
    }
    
    //初始化dropMune
    
    func createDropMenu(array1:Array<NSDictionary>,array2:Array<NSDictionary>){
        let dropDownItem1 = NSMutableArray()
        
        for i in 0 ..< array1.count {
            let dict = array1[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem1.addObject(item)
        }
       
        let dropDownItem2 = NSMutableArray()
        for i in 0 ..< array2.count {
            let dict = array2[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem2.addObject(item)
        }
        
        self.dropDownMenu1?.removeFromSuperview()
        self.dropDownMenu1 = IGLDropDownMenu()
        self.dropDownMenu1?.menuText = "展开详细列表"
        self.dropDownMenu1?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu1?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        self.dropDownMenu1?.paddingLeft = 15
        self.dropDownMenu1?.delegate = self
        self.dropDownMenu1?.type = .Stack
        self.dropDownMenu1?.itemAnimationDelay = 0.1
        self.dropDownMenu1?.gutterY = 5
        self.dropDownMenu1?.dropDownItems = dropDownItem1 as [AnyObject]
        self.dropDownMenu1?.frame = CGRectMake(20, 150, SCREEN_WIDTH/2-30, (SCREEN_HIGHT - 200)/7)
        self.view.addSubview(self.dropDownMenu1!)
        self.dropDownMenu1?.reloadView()
        
        self.dropDownMenu2?.removeFromSuperview()
        self.dropDownMenu2 = IGLDropDownMenu()
        self.dropDownMenu2?.menuText = "展开详细列表"
        self.dropDownMenu2?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu2?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        self.dropDownMenu2?.paddingLeft = 15
        self.dropDownMenu2?.delegate = self
        self.dropDownMenu2?.type = .Stack
        self.dropDownMenu2?.itemAnimationDelay = 0.1
        self.dropDownMenu2?.gutterY = 5
        self.dropDownMenu2?.dropDownItems = dropDownItem2 as [AnyObject]
        self.dropDownMenu2?.frame = CGRectMake(SCREEN_WIDTH/2+10, 150, SCREEN_WIDTH/2-30, (SCREEN_HIGHT - 200)/7)
        self.view.addSubview(self.dropDownMenu2!)
        self.dropDownMenu2?.reloadView()
        
        
    }
    
    /**
     *  IGLDropDownMenuDelegate
     */
    func dropDownMenu(dropDownMenu: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
        if dropDownMenu == self.dropDownMenu1 {
            let item = self.dropDownMenu1?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu2?.menuButton.text = self.detailType
        }else{
            let item = self.dropDownMenu2?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu1?.menuButton.text = self.detailType
        }
    }
    
    
   
    
    
}
