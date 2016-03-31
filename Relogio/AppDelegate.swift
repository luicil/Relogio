//
//  AppDelegate.swift
//  Relogio
//
//  Created by Luicil Fernandes on 21/02/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //self.window?.rootViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let cAtivN = AtivNotif()
        cAtivN.initNotifs()
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        let Notif : UILocalNotification = UIApplication.sharedApplication().scheduledLocalNotifications![0]
        let cAtivN = AtivNotif()
        cAtivN.desativNotifs()
        let appView : UIViewController = self.window!.rootViewController!
        let cA = Alerts()
        let alert : String = Notif.alertTitle!
        let mensagem : String = Notif.alertBody!
        cA.showAlertNotif(alert, mensagem: mensagem, preferredstyle: UIAlertControllerStyle.Alert, view: appView,
                          completionHandlerOK: {() -> Void in
                            cAtivN.ativaNotifs(appView)}
            ,
                          completionHandlerNOK: {() -> Void in }
        )
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        let cAtivN = AtivNotif()
        cAtivN.desativNotifs()
        if notification.category == "INVITE_CATEGORY" {
            if identifier == "ACCEPT_IDENTIFIER" {
                let appView : UIViewController = self.window!.rootViewController!
                cAtivN.ativaNotifs(appView)
            }
        }
        completionHandler()
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
        if UIApplication.sharedApplication().scheduledLocalNotifications!.count > 0 {
            let Notif : UILocalNotification = UIApplication.sharedApplication().scheduledLocalNotifications![0]
            let dataNow : NSDate = NSDate(timeIntervalSinceNow: 0.0)
            let fireDate = Notif.fireDate
            if fireDate?.compare(dataNow) == NSComparisonResult.OrderedAscending {
                UIApplication.sharedApplication().presentLocalNotificationNow(Notif)
            }
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

