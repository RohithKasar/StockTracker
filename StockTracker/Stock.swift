//
//  Stock.swift
//  StockTracker
//
//  Created by Rohith Kasar on 7/23/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import Foundation
class Stock {
    //MARK:-properties
    
    private var _name: String
    private var _date: String
    private var _key: String
    private var _positions: Int
    private var _firm : String
    
    
    
    var name : String {
        return _name
    }
    var date : String {
        return _date
    }
    
    var key : String {
        return _key
    }
    
    var positions: Int {
        return _positions
    }
    
    var firm: String {
        return _firm
    }
 
    init(name: String, date: String, key: String, positions: Int, firm : String) {
        self._date = date
        self._key = key
        self._name = name
        self._firm = firm
        self._positions = positions
    }
    
    
}
extension Stock : Comparable {
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
    
    
}
