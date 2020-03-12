//
//  FirebaseRetrieveData.swift
//  ParkIt
//
//  Created by Brandon Gouws on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class FirebaseRetrieveData {
    //Creating Instance of real-time database
    var ref = Database.database().reference()
    var parkingSpots = [ParkingSpot]()
    
    func getData(parkingLevel: String,completion: @escaping (_ val: [ParkingSpot]) -> ()) {
        ref.child("Parking").child(parkingLevel).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                let val1 = snap.value
                print("\(key) -- \(val1!)")
                let val: String = String(format: "%@", val1 as! CVarArg)
                let data = key.components(separatedBy: ":")

                let parkingType: ParkingSpotType
                
                switch data[2] {
                case "D":
                    parkingType = .disabled
                case "N":
                    parkingType = .normal
                case "F":
                    parkingType = .family
                default:
                    parkingType = .normal
                }
                
                let parkingSpotLevel: ParkingSpotLevel
                
                switch parkingLevel {
                case "Level0":
                    parkingSpotLevel = .ground
                case "Level1":
                    parkingSpotLevel = .levelOne
                default:
                    parkingSpotLevel = .ground
                }
                
                let parkingSpotStatus: ParkingSpotStatus
                
                switch val {
                case "0":
                    parkingSpotStatus = .vacant
                case "1":
                    parkingSpotStatus = .occupied
                default:
                    parkingSpotStatus = .occupied
                }
                
                let parkingSpot = ParkingSpot(level: parkingSpotLevel, type: parkingType, status: parkingSpotStatus)
                
                self.parkingSpots.append(parkingSpot)
            }
            completion(self.parkingSpots)
        }
    }
}
