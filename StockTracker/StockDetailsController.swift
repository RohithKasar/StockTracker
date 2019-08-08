//
//  StockDetailsController.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/12/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase

class StockDetailsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let DB_BASE = Database.database().reference()
    var stock = ""
    
    var soldTransaction = Transaction(name: "", price: 0, amount: 0, firm: "", portfolio: "", date: "", sellDate: "", sellValue: 0, transactionID: "", sellAmount : 0)
    
    var transactionList = [Transaction]()
    

    @IBOutlet weak var detailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        
        
        //DataService.instance.fetchPrivateEvents(forUser: currentUser) { (paramPrivateEvents) in
        
        DataService.instance.fetchTransactions(forStock: stock) { (transactionArray) in
            self.transactionList = transactionArray.reversed()
            self.detailsTableView.reloadData()
        }
        
        
        self.title = stock
        
        
        
        // Do any additional setup after loading the view.
    }
    
 
    
    @IBAction func sellPressed(_ sender: UIButton) {
        
        var indexPath = getCurrentCellIndexPath(sender)
        self.soldTransaction = self.transactionList[(indexPath?.popLast())!]
        
        performSegue(withIdentifier: "sellSegue", sender: self)
        
        //DB_BASE.child("Transaction").child(transaction.transactionID).updateChildValues(["sellDate" : Any])
        
        
        
        
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: detailsTableView)
        
        if let indexPath: IndexPath = detailsTableView.indexPathForRow(at: buttonPosition) {
            
            return indexPath
        }
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        DataService.instance.fetchTransactions(forStock: stock) { (transactionArray) in
            self.transactionList = transactionArray.reversed()
            
            self.detailsTableView.reloadData()
        }
        
        
        self.detailsTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        let transaction = transactionList[indexPath.row]
        
        
        //cell.detailsLabel.text = transaction.name
        
        let stringPrice = String(transaction.price)
        let stringAmount = String(transaction.amount)
        let profit = (transaction.sellValue - transaction.price) * Double(transaction.sellAmount)
        let roundedProfit = Double(round(1000*profit)/1000)
        
        cell.detailsLabel.text = ("Buying " + stringAmount + " " + transaction.name + " at " + stringPrice + " on " + transaction.date)
        if (transaction.sellDate != "") {
            let part1 = "Bought " + stringAmount + " " + transaction.name + " at " + stringPrice + " on " + transaction.date + "\n"
            let part2 = "Sold " + stringAmount + " " + transaction.name + " at " + String(transaction.sellValue) + " on " + transaction.sellDate + "\n"
            let part3 = "Profit: $" + String(roundedProfit)
            
            cell.detailsLabel.text = part1 + part2 + part3
            //cell.detailsLabel.text = ("Bought " + stringAmount + " " + transaction.name + " at " + stringPrice + " on " + transaction.date + "\n" + "Sold " + stringAmount + " " + transaction.name + " at " + String(transaction.sellValue) + " on " + transaction.sellDate + "\n" + "Profit: $" + profit)
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        let sellViewController = segue.destination as! SellViewController
        sellViewController.transaction = soldTransaction
        
        
        
    }
    

}
