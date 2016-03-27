//
//  clsAlerts.swift
//  Relogio
//
//  Created by Luicil Fernandes on 24/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit
import Foundation

class Alerts {
    
    typealias CompletionHandler = () -> Void
    
    func showAlertOKNOK(titulo : String, mensagem: String, preferredstyle : UIAlertControllerStyle, view : UIViewController, completionHandlerOK: CompletionHandler,completionHandlerNOK: CompletionHandler) {
        let refreshAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: preferredstyle)
        
        refreshAlert.addAction(UIAlertAction(title: "Sim", style: .Destructive, handler: { (action: UIAlertAction!) in
            completionHandlerOK()
            //return true
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Não", style: .Default, handler: { (action: UIAlertAction!) in
            completionHandlerNOK()
            //return false
        }))
        
        view.presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func showAlertOK(titulo : String, mensagem: String, preferredstyle : UIAlertControllerStyle, view : UIViewController,completionHandlerOK: CompletionHandler) {
        let refreshAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: preferredstyle)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: { (action: UIAlertAction!) in
            completionHandlerOK()
            //return true
        }))

        view.presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    func showAlertNotif(titulo : String, mensagem: String, preferredstyle : UIAlertControllerStyle, view : UIViewController, completionHandlerOK: CompletionHandler,completionHandlerNOK: CompletionHandler) {
        let refreshAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: preferredstyle)
        
        refreshAlert.addAction(UIAlertAction(title: "Continuar Notificar", style: .Default, handler: { (action: UIAlertAction!) in
            completionHandlerOK()
            //return true
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Parar Notificar", style: .Destructive, handler: { (action: UIAlertAction!) in
            completionHandlerNOK()
            //return false
        }))
        
        view.presentViewController(refreshAlert, animated: true, completion: nil)
    }

}