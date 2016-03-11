//
//  ChangeColorViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 10/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class ChangeColorViewController: UIViewController {

    
    @IBOutlet weak var sliderVermelho: UISlider!
    @IBOutlet weak var sliderAzul: UISlider!
    @IBOutlet weak var sliderVerde: UISlider!
    @IBOutlet weak var imageViewCor: UIImageView!
    
    var titulo : String?
    var chave : String?
    var cor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageViewCor.layer.borderWidth = 1.0
        var red : CGFloat = 0.0
        var green : CGFloat = 0.0
        var blue : CGFloat = 0.0
        var alpha : CGFloat = 1.0
        cor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
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
    
    
    func ChangeColor() {
        let r : CGFloat = CGFloat(self.sliderVermelho.value) / CGFloat(255.0)
        let g : CGFloat = CGFloat(self.sliderVerde.value) / CGFloat(255.0)
        let b : CGFloat = CGFloat(self.sliderAzul.value) / CGFloat(255.0)
        
        self.imageViewCor.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
    }
    
    
    @IBAction func sliderVermelhoAct(sender: UISlider) {
        self.ChangeColor()
    }
    
    @IBAction func sliderAzulAct(sender: UISlider) {
        self.ChangeColor()
    }
    
    @IBAction func sliderVerde(sender: UISlider) {
        self.ChangeColor()
    }
    
    @IBAction func cancelarBtn(sender: UIButton) {
    }
    
    @IBAction func confirmarBtn(sender: UIButton) {
    }
    

}
