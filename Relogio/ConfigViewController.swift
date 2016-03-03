//
//  ConfigViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 01/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet weak var viewDigRelogio: UIView!
    @IBOutlet weak var sliderDigRelogio: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewDigRelogio.layer.borderWidth = 1.0
        viewDigRelogio.layer.cornerRadius = 40.0
        
        self.sliderDigRelogio.setValue(Float(self.readnDig()), animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func savenDig(nDig : Int) {
        let cPers = RelogioPersistance()
        cPers.saveDigRelogio(nDig)
    }
    
    func readnDig() -> Int {
        let cPers = RelogioPersistance()
        return cPers.loadDigRelogio()
    }
    
    
    @IBAction func sliderDigRelogioAct(sender: AnyObject) {
        sender.setValue(Float(lroundf(self.sliderDigRelogio.value)), animated: true)
        self.savenDig(Int(self.sliderDigRelogio.value))
    }
    

    @IBAction func gestureRel2Act(sender: UITapGestureRecognizer) {
        self.sliderDigRelogio.setValue(1, animated: true)
        self.savenDig(Int(self.sliderDigRelogio.value))
    }

    @IBAction func gestureRel4Act(sender: UITapGestureRecognizer) {
        self.sliderDigRelogio.setValue(2, animated: true)
        self.savenDig(Int(self.sliderDigRelogio.value))
    }
    
    @IBAction func gestureRel12Act(sender: UITapGestureRecognizer) {
        self.sliderDigRelogio.setValue(3, animated: true)
        self.savenDig(Int(self.sliderDigRelogio.value))
    }
    

}
