//
//  DataService.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/16/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import Foundation

import FirebaseDatabase


//let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()

    func pushTransaction(name : String, amount: String, price: String, portfolio: String, firm:String, date:String, buyOrSell:String,
        uploadComplete: @escaping (_ status: Bool) -> ()) {
        
        
    }
    
    
   
    
    func fetchStocks(handler: @escaping ( _ stocks: [Stock]) -> ()) {
        var stockArray = [Stock]()
        let DB_BASE = Database.database().reference()
        let REF_STOCK = DB_BASE.child("Stocks")
        REF_STOCK.observeSingleEvent(of: .value) { (allStocksSnapshot) in
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
        }
    }
    
    
    
    func fetchTransactions(forStock stockName: String, handler: @escaping ( _ transactions: [Transaction]) -> ()) {
        var transactionArray = [Transaction]()
        let DB_BASE = Database.database().reference()
        let REF_TRANSACTIONS = DB_BASE.child("Transactions")
        
        REF_TRANSACTIONS.observeSingleEvent(of : .value) { (allTransactionsSnapshot) in
            guard let allTransactionsSnapshot = allTransactionsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for transaction in allTransactionsSnapshot {
                
                let name = transaction.childSnapshot(forPath: "name").value as! String
                //print(name)
                if (name == stockName) {
                    //print("hello from fetch")
                    let stringAmount = transaction.childSnapshot(forPath: "amount").value as! String
                    let date = transaction.childSnapshot(forPath: "date").value as! String
                    let stringPrice = transaction.childSnapshot(forPath: "price").value as! String
                    let portfolio = transaction.childSnapshot(forPath: "portfolio").value as! String
                    let firm = transaction.childSnapshot(forPath: "firm").value as! String
                    let sellDate = transaction.childSnapshot(forPath: "sellDate").value as! String
                    let stringSellValue = transaction.childSnapshot(forPath: "sellValue").value as! String
                    let transactionID = transaction.childSnapshot(forPath: "transactionID").value as! String
                    let stringSellAmount = transaction.childSnapshot(forPath: "sellAmount").value as! String
                    
                    
                    let amount = Int(stringAmount)
                    let price = Double(stringPrice)
                    let sellValue = Double(stringSellValue)
                    let sellAmount = Int(stringSellAmount)
                    
                    let transaction: Transaction = Transaction(name: name, price: price ?? 0 , amount: amount ?? 0, firm: firm, portfolio: portfolio, date: date, sellDate: sellDate, sellValue: sellValue ?? 0, transactionID : transactionID, sellAmount : sellAmount ?? 0)
                    transactionArray.append(transaction)
                }
                
            }
            
            handler(transactionArray)
        }
    }
    
   
}


