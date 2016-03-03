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

        var nDig : Int = defaults.integerForKey("nDig")
        if nDig == 0 {
            nDig = 3
        }
        return nDig
        
    }
}