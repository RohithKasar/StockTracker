//
//  SettingsViewController.swift
//  StockTracker
//
//  Created by Rohith Kasar on 8/19/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var firmList = [String]()
    
    @IBOutlet weak var firmTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firmTableView.delegate = self
        firmTableView.dataSource = self
        
        DataService.instance.fetchFirms(forUser: DummyUser.globalVariable.id) { (firmList) in
        
        
            self.firmList = firmList.reversed()
            self.firmTableView.reloadData()
            
        }
            

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.fetchFirms(forUser: DummyUser.globalVariable.id) { (firmList) in
            
            
            self.firmList = firmList.reversed()
            self.firmTableView.reloadData()
            
        }
        self.firmTableView.reloadData()
        
    }
    

    
    @IBAction func plusClicked(_ sender: Any) {
        performSegue(withIdentifier: "addFirm", sender: self)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        performSegue(withIdentifier: "cancelSettings", sender: self)
        //dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: self)
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirmCell") as! FirmCell
        let firm = firmList[indexPath.row]
        
        cell.firmName.text = firm
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
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
