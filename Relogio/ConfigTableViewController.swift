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
    @IBOutlet weak var lblAtivNotifs: UILabel!
    @IBOutlet weak var lblMinutosNotifs: UILabel!
    @IBOutlet weak var stepperNotif: UIStepper!
    @IBOutlet weak var switchNotifs: UISwitch!
    @IBOutlet weak var switchRepetir: UISwitch!
    @IBOutlet weak var configTableView: UITableView!
    
    var minutosNotif : Int = 1
    var switchNotif : Bool = false
    
    let sectionCores : Int = 1
    
    let arrCores : [String] = ["Cor para o Ponteiro das Horas","Cor para o Ponteiro dos Minutos","Cor para o Ponteiro dos Segundos","Cor do Fundo do Relógio","Cor do Fundo da Tela","Cor da Borda e Dígitos do Relógio","Círculo do Centro do Relógio"]
    let chavesCores : [String] = ["corPontHoras","corPontMinutos","corPontSegundos","corFundoRelogio","corFundoTela","corBordaDigitosRelogio","corCirculoCentroRelogio"]
    let defautCores : [UIColor] = [UIColor.blackColor(),UIColor.whiteColor(),UIColor.redColor(),UIColor.grayColor(),UIColor.blackColor(),UIColor.whiteColor(),UIColor.whiteColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        //self.checkConfigs()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.checkConfigs()
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
            let vc : ChangeColorViewController = self.storyboard!.instantiateViewControllerWithIdentifier("viewChangeColor") as! ChangeColorViewController
            vc.titulo = arrCores[linha]
            vc.chave = chavesCores[linha]
            vc.defaultCor = defautCores[linha]
            self.showViewController(vc, sender: vc)
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
    
    func checkConfigs() {
        let cPers = RelogioPersistance()
        switchNotif = cPers.loadSwitchNotif() && (cPers.loadNFrases() > 0)
        minutosNotif = cPers.loadMinutosNotif()
        self.sliderRelogio.setValue(Float(self.readnDig()), animated: true)
        self.loadImage()
        self.sliderTransparencia.setValue(self.loadTransparencia(), animated: true)
        self.switchNotifs.setOn(switchNotif, animated: true)
        self.changeAlpha()
        self.showMinutos()
        self.showNotifs()
        self.switchNotifs.enabled = (cPers.loadNFrases() > 0)
        self.switchRepetir.setOn(cPers.loadSwitchRepetir(), animated: true)
    }

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
    
    func showMinutos() {
        if minutosNotif > 1 {
            self.lblMinutosNotifs.text = "A cada \(minutosNotif) minutos"
        } else {
            self.lblMinutosNotifs.text = "A cada \(minutosNotif) minuto"
        }
        
    }
    
    func showNotifs() {
        let cativNotif = AtivNotif()
        if switchNotif {
            self.lblAtivNotifs.text = "Desativar Notificações"
            self.lblMinutosNotifs.enabled = true
            self.stepperNotif.enabled = true
            cativNotif.desativNotifs()
            cativNotif.ativaNotifs(self)
        } else {
            self.lblAtivNotifs.text = "Ativar Notificações"
            self.lblMinutosNotifs.enabled = false
            self.stepperNotif.enabled = false
            cativNotif.desativNotifs()
        }
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
        
        let refreshAlert = UIAlertController(title: "Configurações", message: "Deseja excluir a imagem ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
            self.imageView.image = nil
            self.deleteImage()
            self.sliderTransparencia.setValue(1.0, animated: true)
            self.changeAlpha()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Não", style: .Default, handler: { (action: UIAlertAction!) in
            //não faz nada
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func sliderTransparenciaAct(sender: UISlider) {
        self.changeAlpha()
    }
    
    @IBAction func actSwitchAtivNotifs(sender: UISwitch) {
        switchNotif = sender.on
        let cPers = RelogioPersistance()
        cPers.saveSwitchNotif(switchNotif)
        self.showNotifs()
    }
    
    
    @IBAction func actSwitchRepetir(sender: UISwitch) {
        let cPers = RelogioPersistance()
        cPers.saveSwitchRepetir(sender.on)
        if cPers.loadSwitchNotif() {
            let cativNotif = AtivNotif()
            cativNotif.ativaNotifs(self)
        }
    }
    
    
    @IBAction func actStepperMinutosNotif(sender: UIStepper) {
        minutosNotif  = Int(sender.value)
        let cPers = RelogioPersistance()
        cPers.saveMinutosNotif(minutosNotif)
        self.showMinutos()
        let cativNotif = AtivNotif()
        cativNotif.ativaNotifs(self)
    }
    
}
