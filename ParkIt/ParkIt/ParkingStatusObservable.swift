//
//  ParkingStatusObservable.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/12.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

protocol ParkingStatusObservable {
  
  var parkingStatusObservers: [ParkingStatusObserver] {get set}
  
  func subscribeToParkingStatusObservable(with observer: ParkingStatusObserver)
  
}

extension ParkingStatusObservable {
  
  mutating func subscribeToParkingStatusObservable(with observer: ParkingStatusObserver) {
    parkingStatusObservers.append(observer)
  }
  
}
