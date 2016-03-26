//
//  clsPersistance.swift
//  Relogio
//
//  Created by Luicil Fernandes on 02/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit
import Foundation

class RelogioPersistance {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func saveDigRelogio(nDig : Int) {
        defaults.setInteger(nDig, forKey: "nDig")
        defaults.synchronize()
    }
    
    func loadDigRelogio() -> Int {

        var nDig : Int = defaults.integerForKey("nDig")
        if nDig == 0 {
            nDig = 3
        }
        return nDig
        
    }
    
    func saveFrases(tableData : [String]) {
        defaults.setObject(tableData as [NSString], forKey: "frases")
        defaults.synchronize()
    }
    
    func loadFrases() -> [NSString] {

        if let savedData : [NSString] = defaults.objectForKey("frases") as? [NSString] {

            return savedData
        }
        return []
    }
    
    func loadNFrases() -> Int {
        if let savedData : [NSString] = defaults.objectForKey("frases") as? [NSString] {
            
            return savedData.count
        }
        return 0
    }
    
    func saveImage(img : UIImage) {
        if let data = UIImagePNGRepresentation(img) {
            defaults.setObject(data, forKey: "backImage")
            defaults.synchronize()
        }
        
    }
    
    func loadImage() -> UIImage {
        let myOutput: AnyObject? = defaults.objectForKey("backImage")
        if myOutput != nil {
            return UIImage(data: myOutput! as! NSData)!
        }
        return UIImage()
    }
    
    func deleteImage() {
        defaults.removeObjectForKey("backImage")
        defaults.synchronize()
    }
    
    func saveTransparencia(valTransp : Float) {
        defaults.setFloat(valTransp, forKey: "transparencia")
        defaults.synchronize()
    }
    
    func loadTransparencia() -> Float {
        return defaults.floatForKey("transparencia")
    }
    
    func loadCor(chave : String, defaultColor : UIColor) -> UIColor {
        //let cor : AnyObject? = defaults.objectForKey(chave)
        
        let cor = defaults.dataForKey(chave)
        
        if cor != nil {
            return NSKeyedUnarchiver.unarchiveObjectWithData(cor!) as! UIColor
        }
        return defaultColor

    }
    
    func saveCor(chave : String, cor : UIColor) {
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(cor), forKey: chave)
        defaults.synchronize()
    }
    
    func loadSwitchNotif() -> Bool {
        return defaults.boolForKey("switchNotif")
    }
    
    func saveSwitchNotif(on : Bool) {
        defaults.setBool(on, forKey: "switchNotif")
        defaults.synchronize()
    }
    
    func loadMinutosNotif() -> Int {
        var min : Int = defaults.integerForKey("minutosNotif")
        if min == 0 {
            min = 1
        }
        return min
    }
    
    func saveMinutosNotif(minutos : Int) {
        defaults.setInteger(minutos, forKey: "minutosNotif")
        defaults.synchronize()
    }
    
}
