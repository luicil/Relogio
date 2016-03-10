//
//  ConfigTableViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 09/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class ConfigTableViewController: UITableViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var sliderRelogio: UISlider!
    @IBOutlet weak var sliderTransparencia: UISlider!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.sliderRelogio.setValue(Float(self.readnDig()), animated: true)
        self.loadImage()
        self.sliderTransparencia.setValue(self.loadTransparencia(), animated: true)
        self.changeAlpha()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        imageView.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
        self.saveImage()
    }
    
    func savenDig(nDig : Int) {
        let cPers = RelogioPersistance()
        cPers.saveDigRelogio(nDig)
    }
    
    func readnDig() -> Int {
        let cPers = RelogioPersistance()
        return cPers.loadDigRelogio()
    }
    
    func saveImage() {
        let cPers = RelogioPersistance()
        cPers.saveImage(imageView.image!)
    }
    
    func loadImage() {
        let cPers = RelogioPersistance()
        imageView.image = cPers.loadImage()
    }
    
    func deleteImage() {
        let cPers = RelogioPersistance()
        cPers.deleteImage()
    }
    
    func saveTransparencia(valTransparencia : Float) {
        let cPers = RelogioPersistance()
        cPers.saveTransparencia(valTransparencia)
    }
    
    func loadTransparencia() -> Float {
        let cPers = RelogioPersistance()
        return cPers.loadTransparencia()
    }
    
    func changeAlpha() {
        imageView.alpha = CGFloat(sliderTransparencia.value)
        self.saveTransparencia(self.sliderTransparencia.value)
    }
    
    @IBAction func gesture2Act(sender: UITapGestureRecognizer) {
        self.sliderRelogio.setValue(1, animated: true)
        self.savenDig(Int(self.sliderRelogio.value))
    }
    
    @IBAction func gesture4Act(sender: UITapGestureRecognizer) {
        self.sliderRelogio.setValue(2, animated: true)
        self.savenDig(Int(self.sliderRelogio.value))
    }
    
    @IBAction func gesture12Act(sender: UITapGestureRecognizer) {
        self.sliderRelogio.setValue(3, animated: true)
        self.savenDig(Int(self.sliderRelogio.value))
    }
    
    @IBAction func sliderRelogioAct(sender: UISlider) {
        sender.setValue(Float(lroundf(self.sliderRelogio.value)), animated: true)
        self.savenDig(Int(self.sliderRelogio.value))
    }
    
    @IBAction func editImageBtn(sender: UIButton) {
        let imag = UIImagePickerController()
        imag.delegate = self
        imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imag.allowsEditing = false
        self.presentViewController(imag, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteImageBtn(sender: UIButton) {
        imageView.image = nil
        self.deleteImage()
        self.sliderTransparencia.setValue(1.0, animated: true)
        self.changeAlpha()
    }
    
    @IBAction func sliderTransparenciaAct(sender: UISlider) {
        self.changeAlpha()
    }
    
}
