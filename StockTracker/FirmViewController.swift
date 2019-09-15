//
//  FirmViewController.swift
//  StockTracker
//
//  Created by Rohith Kasar on 8/5/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase
class FirmViewController: UIViewController {
    
    let DB_BASE = Database.database().reference()
    
    
    @IBOutlet weak var firmField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneClicked(_ sender: Any) {
        let firm = firmField.text!
        //DB_BASE.child("Users").child(DummyUser.globalVariable.id).updateChildValues(["firms": firm])
        DB_BASE.child("Users").child(DummyUser.globalVariable.id).child("Firms").childByAutoId().updateChildValues(["name":firm])
        //DB_BASE.child("firms").childByAutoId().updateChildValues(["list" : firmField.text!])
        //DB_BASE.child("firms").childByAutoId().setValue(firmField.text!)
        //dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "backHome", sender: self)
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
