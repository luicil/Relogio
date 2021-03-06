//
//  FrasesViewController.swift
//  Relogio
//
//  Created by Luicil Fernandes on 21/02/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class FrasesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var tableData : [String] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        checkForSavedData()
        
        
        self.hidesBottomBarWhenPushed = true
        self.navigationItem.hidesBackButton = true

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
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.CustomLabel.text = tableData[indexPath.row]
        cell.excBtn.tag = indexPath.row
        cell.excBtn.addTarget(self, action: #selector(FrasesViewController.excBtn(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func saveData() {

        let cPers = RelogioPersistance()
        cPers.saveFrases(tableData)
        
    }
    
    func checkForSavedData() ->Bool {
        let cPers = RelogioPersistance()
        if let savedData : [NSString] = cPers.loadFrases() {
            for data in savedData {
                tableData.append(data as String)
            }
            tableData.sortInPlace()
            tableView.reloadData()
            return true
        }
        return false
    }
    
    func retnData() -> Int {
        let cPers = RelogioPersistance()
        return cPers.loadNFrases()
    }
    
    @IBAction func btnIncuir(sender: AnyObject) {
        if txtField.text != "" {
            tableData.append(txtField.text!)
            tableData.sortInPlace()
            tableView.reloadData()
            saveData()
            txtField.text = ""
        }
    }
    
    @IBAction func excBtn(sender: UIButton) {
    
        let cA = Alerts()
        cA.showAlertOKNOK("Frases Motivacionais", mensagem: "Deseja excluir a frase motivacional ?", preferredstyle: UIAlertControllerStyle.Alert, view: self, completionHandlerOK: { () -> Void in
            //print("teste" )
            let pos : Int = sender.tag
            self.tableData.removeAtIndex(pos)
            self.saveData()
            self.tableView.reloadData()
            if self.retnData() == 0 {
                let cNotifs = AtivNotif()
                cNotifs.desativNotifs()
                let cPers = RelogioPersistance()
                cPers.saveSwitchNotif(false)
            }
            },completionHandlerNOK: { () -> Void in })
        
//        let refreshAlert = UIAlertController(title: "Frases Motivacionais", message: "Deseja excluir a frase motivacional ?", preferredStyle: UIAlertControllerStyle.Alert)
//        
//        refreshAlert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction!) in
//            let pos : Int = sender.tag
//            self.tableData.removeAtIndex(pos)
//            self.saveData()
//            self.tableView.reloadData()
//        }))
//        
//        refreshAlert.addAction(UIAlertAction(title: "Não", style: .Default, handler: { (action: UIAlertAction!) in
//            //não faz nada
//        }))
//        
//        presentViewController(refreshAlert, animated: true, completion: nil)
        
        

        
    }
}

extension FrasesViewController : UITextFieldDelegate {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}

