//
//  ConfigViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 01/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //@IBOutlet weak var viewDigRelogio: UIView!
    @IBOutlet weak var sliderDigRelogio: UISlider!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!

    
    
    let tableData = ["Ponteiro de Horas","Ponteiro de Minutos","Ponteiro de Segundos","Fundo do Relógio","Fundo da Tela","Borda e Dígitos"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //viewDigRelogio.layer.borderWidth = 1.0
        //viewDigRelogio.layer.cornerRadius = 40.0
        //scrollView.layer.cornerRadius = 40.0
        
        self.sliderDigRelogio.setValue(Float(self.readnDig()), animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self


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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomConfigTableViewCell", forIndexPath: indexPath) as! CustomConfigTableViewCell
        cell.labelColorCell.text = tableData[indexPath.row]
        cell.editColorBtn.tag = indexPath.row
        cell.editColorBtn.addTarget(self, action: "editColorBtn:", forControlEvents: .TouchUpInside)
        return cell
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        imageView.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    
    @IBAction func editColorBtn(sender: UIButton) {
        

    }
    
    @IBAction func excFundTelaBtn(sender: UIButton) {
        imageView.image = nil
    }
    
    @IBAction func editFundTelaBtn(sender: UIButton) {
        let imag = UIImagePickerController()
        imag.delegate = self
        imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imag.allowsEditing = false
        self.presentViewController(imag, animated: true, completion: nil)
        
        
        
    }

}
