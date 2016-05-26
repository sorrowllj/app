//
//  AppDelegate.swift
//  Elite
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //初始化leancloud
        
        AVOSCloud.setApplicationId("fxsBL3KPfxq8YAMuxxKz4rqn-gzGzoHsz", clientKey: "LekfrlH4MRHq2dMK8B7eMEU6")
        
        self.window = UIWindow(frame: CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HIGHT))
        let tarbarController = UITabBarController()
        
        let rankController = UINavigationController(rootViewController: rankViewController())
        let searchController = UINavigationController(rootViewController: searchViewController())
        let pushController = UINavigationController(rootViewController: pushViewController())
        //let circleController = UINavigationController(rootViewController: circleViewContreller())
        let moreController = UINavigationController(rootViewController: moreViewContreller())
        
        tarbarController.viewControllers = [rankController,searchController,pushController,moreController]
        
        let tarbarItem1 = UITabBarItem(title: "运动广场", image: UIImage(named: "bio"), selectedImage: UIImage(named:"bio_red"))
        let tarbarItem2 = UITabBarItem(title: "球场风采", image: UIImage(named: "timer 2"), selectedImage: UIImage(named:"timer 2_red"))
        let tarbarItem3 = UITabBarItem(title: "我的运动", image: UIImage(named: "pencil"), selectedImage: UIImage(named:"pencil_red"))
        //let tarbarItem4 = UITabBarItem(title: "朋友圈", image: UIImage(named: "users two-2"), selectedImage: UIImage(named:"users two-2_red"))
        let tarbarItem5 = UITabBarItem(title: "我", image: UIImage(named: "more"), selectedImage: UIImage(named:"more_red"))
        
        rankController.tabBarItem = tarbarItem1
        searchController.tabBarItem = tarbarItem2
        pushController.tabBarItem = tarbarItem3
        //circleController.tabBarItem = tarbarItem4
        moreController.tabBarItem = tarbarItem5
        
        rankController.tabBarController?.tabBar.tintColor = MAIN_RED
        self.window?.rootViewController = tarbarController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

