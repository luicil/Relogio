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

    @IBOutlet weak var configTableView: UITableView!
    
    let sectionCores : Int = 1
    
    let corPonteirodasHoras : Int = 0
    let corPonteirodosMinutos : Int = 1
    let corPonteirodosSegundos : Int = 2
    let corFundodoRelogio : Int = 3
    let corFundodaTela : Int = 4
    let corBordaeDigitosdoRelogio : Int = 5
    
    let arrCores : [String] = ["Cor para o Ponteiro das Horas","Cor para o Ponteiro dos Minutos","Cor para o Ponteiro dos Segundos","Cor do Fundo do Relógio","Cor do Fundo da Tela","Cor da Borda e Dígitos do Relógio"]
    
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        if section == sectionCores {
            let linha = indexPath.row
            //prepareForSegue(<#T##segue: UIStoryboardSegue##UIStoryboardSegue#>, sender: self)
            
            
            switch linha {
            case corPonteirodasHoras:
                let a = 1+1
            case corPonteirodosMinutos:
                let a = 1+1
            case corPonteirodosSegundos:
                let a = 1+1
            case corFundodoRelogio:
                let a = 1+1
            case corFundodaTela:
                let a = 1+1
            case corBordaeDigitosdoRelogio:
                let a = 1+1
            default:
                let a = 1+1
                
            }
            
        }
    }
    
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
