//
//  AppDelegate.swift
//  ZhihuDaily
//
//  Created by tangshi on 15/8/4.
//  Copyright © 2015年 tangshi. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        showLauchImage()
        
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

    func showLauchImage() {
        let url_string = "http://news-at.zhihu.com/api/5/start-image/720*1184"
        
        Alamofire.request(.GET, url_string).responseJSON { (_, _, result) -> Void in
            if let obj = result.value {
                let dict = obj as! NSDictionary
                
                let screen_size = UIScreen.mainScreen().bounds.size
                
                let img = UIImageView(frame:CGRectMake(0, 0, screen_size.width, screen_size.height))
                img.backgroundColor = UIColor.blackColor()
                img.contentMode = .ScaleAspectFit
                
                let window = UIApplication.sharedApplication().keyWindow
                window!.addSubview(img)
                
                let image_url_string = dict["img"] as! String
                Alamofire.request(.GET, image_url_string).response(completionHandler: { (_, _, data, _) -> Void in
                    if let image_data = data {
                        img.image = UIImage(data: image_data)
                    }
                })
                
                let lbl = UILabel(frame:CGRectMake(0, screen_size.height-50, screen_size.width, 20))
                lbl.backgroundColor = UIColor.clearColor()
                lbl.text = dict["text"] as? String
                lbl.textColor = UIColor.grayColor()
                lbl.textAlignment = NSTextAlignment.Center
                lbl.font = UIFont.systemFontOfSize(14)
                window!.addSubview(lbl)
                
                UIView.animateWithDuration(3,animations:{
                    let height = UIScreen.mainScreen().bounds.size.height
                    let rect = CGRectMake(-100,-100, screen_size.width+200, height+200)
                    img.frame = rect
                    },completion:{
                        (Bool completion) in
                        
                        if completion {
                            UIView.animateWithDuration(1,animations:{
                                img.alpha = 0
                                lbl.alpha = 0
                                },completion:{
                                    (Bool completion) in
                                    
                                    if completion {
                                        img.removeFromSuperview()
                                        lbl.removeFromSuperview()
                                    }
                            })
                        }
                })
                
            }
            
        }
    }


}

