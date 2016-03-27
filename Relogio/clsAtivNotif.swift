//
//  clsAtivNotif.swift
//  Relogio
//
//  Created by Luicil Fernandes on 22/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit
import Foundation

class AtivNotif {

    func initNotifs() {
        let notificationActionOk :UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        notificationActionOk.identifier = "ACCEPT_IDENTIFIER"
        notificationActionOk.title = "Continuar Notificar"
        notificationActionOk.destructive = false
        notificationActionOk.authenticationRequired = false
        notificationActionOk.activationMode = UIUserNotificationActivationMode.Foreground
        
        let notificationActionCancel :UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        notificationActionCancel.identifier = "NOT_NOW_IDENTIFIER"
        notificationActionCancel.title = "Parar Notificar"
        notificationActionCancel.destructive = true
        notificationActionCancel.authenticationRequired = false
        notificationActionCancel.activationMode = UIUserNotificationActivationMode.Foreground
        
        let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        notificationCategory.identifier = "INVITE_CATEGORY"
        notificationCategory .setActions([notificationActionOk, notificationActionCancel], forContext: UIUserNotificationActionContext.Default)
        notificationCategory .setActions([notificationActionOk, notificationActionCancel], forContext: UIUserNotificationActionContext.Minimal)
        
        //let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: nil)
        
        let categories: Set = Set(arrayLiteral: notificationCategory)
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func ativaNotifs(view : UIViewController) {
        self.desativNotifs()
        let cPers = RelogioPersistance()
        let Minutos = cPers.loadMinutosNotif() * 60
        let switchNotif = cPers.loadSwitchNotif()
        if switchNotif {
            if let savedData : [NSString] = cPers.loadFrases() {
                let nItens : Int = savedData.count
                if nItens > 0 {
                    //nItens += 1
                    let rndNumber : Int = Int(arc4random_uniform(UInt32(nItens)))
                    let localNotification = UILocalNotification()
                    localNotification.fireDate = NSDate(timeIntervalSinceNow: Double(Minutos))
                    localNotification.alertTitle = "Relógio"
                    localNotification.alertBody = savedData[rndNumber] as String
                    localNotification.timeZone = NSTimeZone.defaultTimeZone()
                    localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
                    localNotification.category = "INVITE_CATEGORY"
                    localNotification.soundName = UILocalNotificationDefaultSoundName
                    if cPers.loadSwitchRepetir() {
                        localNotification.repeatInterval = NSCalendarUnit.Minute
                    }
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                } else {
                    let cAlert = Alerts()
                    cAlert.showAlertOK("Relógio", mensagem: "Não há frases motivacionais !\n As notificações serão desativadas.", preferredstyle: UIAlertControllerStyle.Alert, view: view, completionHandlerOK: { () -> Void in
                        let cPers = RelogioPersistance()
                        cPers.saveSwitchNotif(false)
                    })
                }
            }
        }
    }
    
    func desativNotifs() {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        UIApplication.sharedApplication().scheduledLocalNotifications?.removeAll()
    }
    
}