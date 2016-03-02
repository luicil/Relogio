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
    
    @IBAction func sliderDigRelogioAct(sender: AnyObject) {
        sender.setValue(Float(lroundf(self.sliderDigRelogio.value)), animated: true)
    }
    

    @IBAction func gestureRel2Act(sender: UITapGestureRecognizer) {
        self.sliderDigRelogio.setValue(1, animated: true)
    }

}
