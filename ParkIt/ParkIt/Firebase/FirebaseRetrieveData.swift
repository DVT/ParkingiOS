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
    
    func getLevelCount(completion: @escaping (_ val: Int) -> ()) {
        ref.child("Parking").observeSingleEvent(of: .value) { (snapshot) in
            let count = snapshot.childrenCount
            completion(Int(count))
        }
    }
    func getNumAvailableParking(completion: @escaping (_ val: Int) -> ()) {
        getLevelCount { (count) in
            var vacant = 0
            for children in 0 ... count-1 {
                let parkingLevel: String = "Level\(children)"
                self.ref.child("Parking").child(parkingLevel).observeSingleEvent(of: .value) { (snapshot) in
                    for child in snapshot.children {
                        let snap = child as! DataSnapshot
                        let val1 = snap.value
                        let val: String = String(format: "%@", val1 as! CVarArg)
                        if val == "0" {
                            vacant += 1
                        }
                    }
                    completion(vacant)
                }
            }
        }
    }
    func getData(parkingLevel: String,completion: @escaping (_ val: [ParkingSpot]) -> ()) {
        ref.child("Parking").child(parkingLevel).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                let val1 = snap.value
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
    func availableParking(completion: @escaping (_ val: Int) -> ()) {
        ref.child("Parking").child("Level0").observe( .childChanged) { (snapshot) in
            self.getNumAvailableParking { (vacant) in
                completion(vacant)
            }
        }
        ref.child("Parking").child("Level1").observe( .childChanged) { (snapshot) in
            self.getNumAvailableParking { (vacant) in
                completion(vacant)
            }
        }
    }
    func getInformation(parkingLevel: String) {
        //let currentUser = AccountManagement()
        ref.child("Information").child(parkingLevel).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let info = value?["Info"] as? String ?? ""
            let parkingDetails = value?["ParkingDetails"] as? String ?? ""
            let rate = value?["Rate"] as? Int ?? 10
            let stores = value?["Stores"] as? String ?? ""
        }
    }
    func setParkingUser() {
        
    }
    //Test /////
//    func getDataTest(parkingLevel: String,completion: @escaping (_ val: [ParkingSpot]) -> ()) {
//        ref.child("ParkingTest").child(parkingLevel).child("P1").observeSingleEvent(of: .value) { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//            let id = value?["id"] as? String ?? ""
//            let status = value?["Status"] as? String ?? ""
//            let type = value?["Type"] as? String ?? ""
//            print("ID: \(id) Status: \(status) Type: \(type)")
//        }
//    }
}
