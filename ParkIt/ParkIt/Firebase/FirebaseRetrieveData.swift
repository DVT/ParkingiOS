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
                print(data[2])
                var parking = ParkingSpot(level: .ground, type: .normal, status: .occupied)
                if (parkingLevel == "Level0") {
                    if (data[2] == "N" && val == "1") {
                        parking = ParkingSpot(level: .ground, type: .normal, status: .occupied)
                    } else if (data[2] == "D" && val == "1") {
                        parking = ParkingSpot(level: .ground, type: .disabled , status: .occupied)
                    } else if (data[2] == "D" && val == "0") {
                        parking = ParkingSpot(level: .ground, type: .disabled , status: .vacant)
                    } else if (data[2] == "N" && val == "0") {
                        parking = ParkingSpot(level: .ground, type: .normal , status: .vacant)
                    } else if (data[2] == "F" && val == "1") {
                        parking = ParkingSpot(level: .ground, type: .family , status: .occupied)
                    } else if (data[2] == "F" && val == "0") {
                        parking = ParkingSpot(level: .ground, type: .family , status: .vacant)
                    }
                } else if parkingLevel == "Level1" {
                    if (data[2] == "N" && val == "1") {
                        parking = ParkingSpot(level: .levelOne, type: .normal, status: .occupied)
                    } else if (data[2] == "D" && val == "1") {
                        parking = ParkingSpot(level: .levelOne, type: .disabled , status: .occupied)
                    } else if (data[2] == "D" && val == "0") {
                        parking = ParkingSpot(level: .levelOne, type: .disabled , status: .vacant)
                    } else if (data[2] == "N" && val == "0") {
                        parking = ParkingSpot(level: .levelOne, type: .normal , status: .vacant)
                    } else if (data[2] == "F" && val == "1") {
                        parking = ParkingSpot(level: .levelOne, type: .family , status: .occupied)
                    } else if (data[2] == "F" && val == "0") {
                        parking = ParkingSpot(level: .levelOne, type: .family , status: .vacant)
                    }
                }
                self.parkingSpots.append(parking)
            }
            //print("Here is the array: \n\(self.parkingSpots)")
            completion(self.parkingSpots)
        }
    }
}
