//
//  ParkingSpot.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//
import Foundation

enum ParkingSpotLevel: String {
    case ground = "Ground"
    case levelOne = "Level One"
}

enum ParkingSpotType: String {
    case normal = "Nomral Parking"
    case disabled = "Disabled Parking"
    case family = "Family Parking"
}

enum ParkingSpotStatus: String {
    case occupied = "Occupied"
    case vacant = "Vacant"
}

struct ParkingSpot {
    var level: ParkingSpotLevel
    var type: ParkingSpotType
    var status: ParkingSpotStatus
}
