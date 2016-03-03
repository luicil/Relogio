//
//  clsPersistance.swift
//  Relogio
//
//  Created by Luicil Fernandes on 02/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import Foundation

class RelogioPersistance {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func saveDigRelogio(nDig : Int) {
        defaults.setInteger(nDig, forKey: "nDig")
        defaults.synchronize()
    }
    
    func loadDigRelogio() -> Int {
        if let nDig : Int = defaults.integerForKey("nDig") {
            return nDig
        }
        return 3
        
    }
}