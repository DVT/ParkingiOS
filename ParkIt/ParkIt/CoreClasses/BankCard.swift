//
//  BankCard.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//
import Foundation

class BankCard {
  
  var cardNumber: String
  var csvNumber: String
  var expiryDate: String
    var cardCash: Int
  
    init(cardNumber: String, csvNumber: String, expiryDate: String, cardCash: Int) {
    self.cardNumber = cardNumber
    self.csvNumber = csvNumber
    self.expiryDate = expiryDate
    self.cardCash = cardCash
  }
  
}
