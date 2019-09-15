//
//  CreateTransactionViewController.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/15/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

let DB_BASE = Database.database().reference()


class CreateTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    var stockList = [Stock]()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var firmField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    var firmList = [String]()
    
    var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        dateField.placeholder = result
        
        DataService.instance.fetchFirms(forUser: DummyUser.globalVariable.id) { (firmArray) in
            self.firmList = firmArray
            
        }
        
        picker.delegate = self
        picker.dataSource = self
        
        firmField.inputView = picker
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.width, width: self.view.frame.size.height/6, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        //toolBar.barStyle = UIBarStyle.blackTranslucent
        //toolBar.tintColor = UIColor.white
        //toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPressed))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.blue
        //label.text = "Select your organization"
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        firmField.inputAccessoryView = toolBar
        
 
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //AppDelegate.AppUtility.lockOrientation(.portrait)
    }
    
    @objc func cancelPressed(sender: UIBarButtonItem) {
        firmField.text = ""
        firmField.resignFirstResponder()
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        firmField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return firmList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return firmList[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let month = timeOption[0][picker.selectedRow(inComponent: 0)]
//        let day = timeOption[1][picker.selectedRow(inComponent: 1)]
//        let hour = timeOption[2][picker.selectedRow(inComponent: 2)]
//        let minute = timeOption[3][picker.selectedRow(inComponent: 3)]
//        let period = timeOption[4][picker.selectedRow(inComponent: 4)]
        //timeField.text = month + "/" + day + " " + hour + ":" + minute + " " + period
        
        let firm = firmList[picker.selectedRow(inComponent: 0)]
        firmField.text = firm
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = false
        
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func publishClicked(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        
        let name = nameField.text ?? ""
        let price = priceField.text ?? ""
        let amount = amountField.text ?? ""
        let firm = firmField.text ?? ""
        let portfolio = ""
        var dateString = String()
        if (dateField.text != "") {
            dateString = dateField.text!
        } else {
            dateString = result
        }
        
        
        //DATABASE STUFF
        let transactionID = DB_BASE.child("Users").child(DummyUser.globalVariable.id).child("Transactions").childByAutoId()
        let transactionData :[String: Any] = ["name": name, "amount": amount, "price": price, "date": dateString, "firm":firm, "portfolio":portfolio, "transactionID": transactionID.description().dropFirst(89), "sellDate": "", "sellValue" : "", "sellAmount": ""]
        transactionID.updateChildValues(transactionData as [AnyHashable: Any])
        
        //pull all stocks and see if it exists yet. if it exists, update positioning, if not, add it to list
        
        var currentPositions = Int(amount)!
        var firmList = firm
        
        DataService.instance.fetchStocks(forUser: DummyUser.globalVariable.id) { (paramStocks) in
            self.stockList = paramStocks
            var stockID = DB_BASE.child("Users").child(DummyUser.globalVariable.id).child("Stocks").childByAutoId()
            
            
            let myStock = Stock(name: name, date: dateString, key: "", positions: 1, firm: "")
            for stock in self.stockList {
                //MUST ADD extract date HERE
                
                if (stock.name == name) {
                    
                    currentPositions = stock.positions + Int(amount)!
                    stockID = DB_BASE.child("Users").child(DummyUser.globalVariable.id).child("Stocks").child(stock.key)
                    firmList = firmList + ", " + stock.firm
                    
                    if (stock > myStock) {
                        dateString = stock.date
                        
                    }
                }
            }
            //need to compare dates here
            let stringPositions = String(currentPositions)
            
            let stockData : [String: Any] = ["name": name, "date": dateString, "positions": stringPositions, "firm": firmList]
            stockID.updateChildValues(stockData as [AnyHashable: Any])
            
            
        }
//
        
        //print("Buying " + amount + " " + name + " at " + price + " on " + dateString + " for " + firm + " " + portfolio)
        
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
