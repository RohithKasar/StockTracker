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


class CreateTransactionViewController: UIViewController {

    var stockList = [Stock]()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var firmField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        dateField.placeholder = result
        let ref = Database.database().reference().child("firms")
        /*REF_STOCK.observeSingleEvent(of: .value) { (allStocksSnapshot) in
            guard let allStocksSnapshot = allStocksSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for stock in allStocksSnapshot {
                let name = stock.childSnapshot(forPath: "name").value as! String
                let date = stock.childSnapshot(forPath: "date").value as! String
                let stringPositions = stock.childSnapshot(forPath: "positions").value as! String
                let firm = stock.childSnapshot(forPath: "firm").value as! String
                let key = (stock.key)
                
                let positions = Int(stringPositions) ?? 0
                let stock: Stock = Stock(name: name, date: date, key : key, positions: positions, firm: firm)
                stockArray.append(stock)
            }
            
            handler(stockArray)
        }*/
        
        ref.observeSingleEvent(of: .value) { (allFirmsSnapshot) in
            guard let allFirmsSnapshot = allFirmsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for firm in allFirmsSnapshot {
                let text = firm.childSnapshot(forPath: "list").value as! String
                self.firmField.placeholder = text
            }
            
            
            
            
        }
        
        // Do any additional setup after loading the view.
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
        let transactionID = DB_BASE.child("Transactions").childByAutoId()
        let transactionData :[String: Any] = ["name": name, "amount": amount, "price": price, "date": dateString, "firm":firm, "portfolio":portfolio, "transactionID": transactionID.description().dropFirst(54), "sellDate": "", "sellValue" : "", "sellAmount": ""]
        transactionID.updateChildValues(transactionData as [AnyHashable: Any])
        
        //pull all stocks and see if it exists yet. if it exists, update positioning, if not, add it to list
        
        var currentPositions = Int(amount)!
        var firmList = firm
        
        DataService.instance.fetchStocks { (paramStocks) in
            self.stockList = paramStocks
            var stockID = DB_BASE.child("Stocks").childByAutoId()
            
            
            let myStock = Stock(name: name, date: dateString, key: "", positions: 1, firm: "")
            for stock in self.stockList {
                //MUST ADD extract date HERE
                
                if (stock.name == name) {
                    
                    currentPositions = stock.positions + Int(amount)!
                    stockID = DB_BASE.child("Stocks").child(stock.key)
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
