//
//  SellViewController.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/29/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase


class SellViewController: UIViewController {

    let DB_BASE = Database.database().reference()
    var stockList = [Stock]()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    
    
    
    var transaction = Transaction()
    //var name = ""
    //var amount = 0
    
    
//    func setTransaction(transaction : Transaction) {
//        self.transaction = transaction
//    }
    
   
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
//        print("hello1x: " + transaction.name)
        amountField.placeholder = String(transaction.amount)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        dateField.placeholder = result
        nameLabel.text = transaction.name
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        
//        print("hello: " + transaction.name)
        amountField.placeholder = String(transaction.amount)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        dateField.placeholder = result
        
        nameLabel.text = transaction.name
        
    }
    
    @IBAction func sellClicked(_ sender: Any) {
        var sellAmount = String(transaction.amount)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        var sellDate = result
        let sellPrice = priceField.text
        if (amountField.text != "") {
            sellAmount = amountField.text!
        }
        if (dateField.text != "") {
            sellDate = dateField.text!
        }
        DB_BASE.child("Transactions").child(transaction.transactionID).child("sellValue").setValue(sellPrice)
        DB_BASE.child("Transactions").child(transaction.transactionID).child("sellDate").setValue(sellDate)
        DB_BASE.child("Transactions").child(transaction.transactionID).child("sellAmount").setValue(sellAmount)
        
        DataService.instance.fetchStocks { (paramStocks) in
            self.stockList = paramStocks
            var stockID = self.DB_BASE.child("Stocks").childByAutoId()
            var currentPositions = 0
            
            
            for stock in self.stockList {
                //MUST ADD extract date HERE
                
                if (stock.name == self.transaction.name) {
                    
                    currentPositions = stock.positions - Int(self.transaction.amount)
                    stockID = self.DB_BASE.child("Stocks").child(stock.key)
                    
                }
            }
            //need to compare dates here
            let stringPositions = String(currentPositions)
            
            stockID.child("positions").setValue(stringPositions)
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
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
