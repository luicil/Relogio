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

    func ativaNotifs() {
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
                    localNotification.alertBody = savedData[rndNumber] as String
                    localNotification.timeZone = NSTimeZone.defaultTimeZone()
                    localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
                    localNotification.category = "INVITE_CATEGORY";
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                }
            }
        }
    }
    
    func desativNotifs() {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        UIApplication.sharedApplication().scheduledLocalNotifications?.removeAll()
    }
    
}