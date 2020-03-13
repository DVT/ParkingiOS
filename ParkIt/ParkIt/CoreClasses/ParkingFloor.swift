//
//  ParkingFloor.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/12.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

struct ParkingFloor {
  
  var level: ParkingSpotLevel
  var info: String
  var rate: Double
  var parkingDetails: String
  var stores: [String]
  var parkingSpots: [ParkingSpot] = []
  
  init(level: ParkingSpotLevel, info: String, rate: Double, parkingDetails: String, parkingSpots: [ParkingSpot] = [], stores: String...) {
    
    self.level = level
    self.info = info
    self.rate = rate
    self.parkingDetails = parkingDetails
    self.stores = stores
    self.parkingSpots = parkingSpots
    
  }
  
  init(level: ParkingSpotLevel, info: String, rate: Double, parkingDetails: String, stores: [String], parkingSpots: [ParkingSpot] = []) {
    
    self.level = level
    self.info = info
    self.rate = rate
    self.parkingDetails = parkingDetails
    self.stores = stores
    self.parkingSpots = parkingSpots
    
  }
  
}
