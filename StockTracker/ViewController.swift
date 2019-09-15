//
//  ViewController.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/12/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase


class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   

    @IBAction func loginPressed(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)
        
        //performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
}


extension ViewController : FUIAuthDelegate  {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            return
        }
        
//        
        DummyUser.globalVariable.id = authUI.auth?.currentUser?.uid ?? "User"
        DummyUser.globalVariable.email = authUI.auth?.currentUser?.email ?? "email"
        
        //authDataResult?.user.uid
        if (authDataResult?.additionalUserInfo?.isNewUser ?? false) {
            let id = authUI.auth?.currentUser?.uid ?? "UserId"
            let email = authUI.auth?.currentUser?.email ?? "email"
            let name = authUI.auth?.currentUser?.displayName ?? "name"
            let DB_BASE = Database.database().reference()
            let userData : [String: Any?] = ["name": name, "email":email, "id":id]
            //"Stocks": ["hib": "hob"], "Transactions" : ["hib":"hob"], "Firms" : ["hib":"hob"]]
            
            DB_BASE.child("Users").child(id).updateChildValues(userData as [AnyHashable : Any])
            performSegue(withIdentifier: "initialSettings", sender: self)
        }
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
}


