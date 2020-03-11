//
//  User.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//
import Foundation

class User {
  
  var licensePlateNum: String
  var firstName: String
  var lastName: String
  var password: String
  var bankCard: BankCard
  
  init(licensePlateNum: String, firstName: String, lastName: String, password: String, bankCard: BankCard) {
    
    self.licensePlateNum = licensePlateNum
    self.firstName = firstName
    self.lastName = lastName
    self.bankCard = bankCard
    self.password = password
    
  }
  
}
