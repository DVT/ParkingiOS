//
//  ParkingStatusObserver.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/12.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol ParkingStatusObserver {
  
  func parkingSpotBecameOccupied()
  
  func parkingSpotBecameUnoccupied()
  
}
