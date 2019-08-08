//
//  Transaction.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/16/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import Foundation


class Transaction {
    //MARK:-properties
    
    private var _name: String
    private var _price: Double
    private var _amount: Int
    private var _firm: String
    private var _portfolio: String
    private var _date: String
    
    private var _sellDate : String
    private var _sellValue : Double
    private var _transactionID : String
    private var _sellAmount : Int
    
    

    var name : String {
        return _name
    }
    var price : Double {
        return _price
    }
    var amount : Int {
        return _amount
    }
    var firm : String {
        return _firm
    }
    var portfolio : String {
        return _portfolio
    }
    var date : String {
        return _date
    }
    var sellDate : String {
        return _sellDate
    }
    var sellValue : Double {
        return _sellValue
    }
    
    var transactionID : String {
        return _transactionID
    }
    
    var sellAmount : Int {
        return _sellAmount
        
    }
    
    init() {
        self._sellDate = ""
        self._sellValue = 0
        self._date = ""
        self._portfolio = ""
        self._firm = ""
        self._amount = 0
        self._price = 0
        self._name = ""
        self._transactionID = ""
        self._sellAmount = 0
    }
    
    init(name: String, price: Double, amount: Int, firm: String, portfolio: String, date: String, sellDate: String, sellValue: Double, transactionID: String, sellAmount : Int) {
        self._sellDate = sellDate
        self._sellValue = sellValue
        self._date = date
        self._portfolio = portfolio
        self._firm = firm
        self._amount = amount
        self._price = price
        self._name = name
        self._transactionID = transactionID
        self._sellAmount = sellAmount
    }
}
extension Transaction: Comparable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        var leftList = lhs.date.split(separator: "/")
        var rightList = rhs.date.split(separator: "/")
        let leftYear:Int? = Int(leftList[2])
        let leftDate:Int? = Int(leftList[1])
        let leftMonth:Int? = Int(leftList[0])
        
        let rightYear:Int? = Int(rightList[2])
        let rightDate:Int? = Int(rightList[1])
        let rightMonth:Int? = Int(rightList[0])
        
        return leftYear == rightYear && leftMonth == rightMonth
            && leftDate == rightDate
    }
    
    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        var leftList = lhs.date.split(separator: "/")
        var rightList = rhs.date.split(separator: "/")
        let leftYear:Int? = Int(leftList[2])
        let leftDate:Int? = Int(leftList[1])
        let leftMonth:Int? = Int(leftList[0])
        
        let rightYear:Int? = Int(rightList[2])
        let rightDate:Int? = Int(rightList[1])
        let rightMonth:Int? = Int(rightList[0])
        if ((lhs.amount - lhs.sellAmount) == 0) {
            return true
        }
        if (leftYear != rightYear) {
            return leftYear! < rightYear!
        }
        if (leftMonth != rightMonth) {
            return leftMonth! < rightMonth!
        }
        else {
            return leftDate! < rightDate!
        }
    }
}
/*extension Stock : Comparable {
    static func < (lhs: Stock, rhs: Stock) -> Bool {
        var leftList = lhs.date.split(separator: "/")
        var rightList = rhs.date.split(separator: "/")
        let leftYear:Int? = Int(leftList[2])
        let leftDate:Int? = Int(leftList[1])
        let leftMonth:Int? = Int(leftList[0])
        
        let rightYear:Int? = Int(rightList[2])
        let rightDate:Int? = Int(rightList[1])
        let rightMonth:Int? = Int(rightList[0])
        
        if (lhs.positions == 0){
            return true
        }
        
        if (leftYear != rightYear) {
            return leftYear! < rightYear!
        }
        if (leftMonth != rightMonth) {
            return leftMonth! < rightMonth!
        }
        else {
            return leftDate! < rightDate!
        }
        
    }
    
    static func == (lhs: Stock, rhs: Stock) -> Bool {
        var leftList = lhs.date.split(separator: "/")
        var rightList = rhs.date.split(separator: "/")
        let leftYear:Int? = Int(leftList[2])
        let leftDate:Int? = Int(leftList[1])
        let leftMonth:Int? = Int(leftList[0])
        
        let rightYear:Int? = Int(rightList[2])
        let rightDate:Int? = Int(rightList[1])
        let rightMonth:Int? = Int(rightList[0])
        
        return leftYear == rightYear && leftMonth == rightMonth
            && leftDate == rightDate
    }
    
    
}*/


