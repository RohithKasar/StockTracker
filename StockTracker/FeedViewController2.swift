//
//  FeedViewController2.swift
//  StockTracker
//
//  Created by Rohith Kasar on 8/26/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stockList = [Stock]()
    let DB_BASE = Database.database().reference()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DummyUser.globalVariable.id = Firebase.Auth.auth().currentUser?.uid ?? "User"
        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.instance.fetchStocks(forUser: DummyUser.globalVariable.id) { (paramStocks) in
            //sort paramStocks by date
            self.stockList = paramStocks.sorted().reversed()
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DummyUser.globalVariable.id = Firebase.Auth.auth().currentUser?.uid ?? "User"
        
        
        
        //self.stockList = ["ZTO", "AAPL", "YEET", "GOOGL"]
        DataService.instance.fetchStocks(forUser: DummyUser.globalVariable.id) { (paramStocks) in
            //sort paramStocks by date
            self.stockList = paramStocks.sorted().reversed()
            
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    

    @IBAction func settingsClicked(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    @IBAction func plusClicked(_ sender: Any) {
        performSegue(withIdentifier: "publishSeuge", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockList.count
        //return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as! StockCell
        let stock = stockList[indexPath.row]
        
        cell.nameLabel.text = stock.name
        cell.positionLabel.text = String(stock.positions) + " in " + stock.firm
        
        
        
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
        if (segue.identifier == "showDetails") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            
            let stock = stockList[indexPath.row]
            
            let detailsViewController = segue.destination as! StockDetailsController
            detailsViewController.stock = stock.name
            
            
        }
    }
    

}
