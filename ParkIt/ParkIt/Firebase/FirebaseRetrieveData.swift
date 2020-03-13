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
                let idString = key.components(separatedBy: ":")

                let parkingID = data[0]
                
                switch data[1] {
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
                
                let parkingSpot = ParkingSpot(level: parkingSpotLevel, type: parkingType, status: parkingSpotStatus, parkingID: parkingID)
                
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
    func getInformation(parkingSpotLevel: ParkingSpotLevel, parkingSpots: [ParkingSpot]) {
        let checkData: ParkingSpotLevel = .levelOne
        var levelString = ""
        if parkingSpotLevel == checkData {
            levelString = "Level1"
        } else {
            levelString = "Level0"
        }
        ref.child("Information").child(levelString).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let info = value?["Info"] as? String ?? ""
            let parkingDetails = value?["ParkingDetails"] as? String ?? ""
            let rate = value?["Rate"] as? Int ?? 10
            let stores = value?["Stores"] as? String ?? ""
            
            let data = stores.components(separatedBy: ",")
            var allStores = [String]()
            for store in data {
                allStores.append(store)
            }
            print("Info: \(info) \n Rate: \(rate) \n Parking Details: \(parkingDetails) \n Stores: \(allStores) \n Parking Level: \(parkingSpotLevel) \n Parking Spot Array: \(parkingSpots)")
            }
    }
    func getParkingID(index: Int, parkingSpotLevel: ParkingSpotLevel) {
        let checkData: ParkingSpotLevel = .levelOne
        var levelString = ""
        if parkingSpotLevel == checkData {
            levelString = "Level1"
        } else {
            levelString = "Level0"
        }
        getData(parkingLevel: levelString) { (parking) in
            let parkingID = parking[index].parkingID
            print(" This is the current parkingID: \(parkingID)")
            self.setParkingUser(parkingID: parkingID)
        }
    }
    func setParkingUser(parkingID: String) {
        let userID = Auth.auth().currentUser?.uid
        let myFire = AccountManagement()
        myFire.getUser { (success, currentUser) in
            let licensePlate = currentUser.licensePlateNum
            let firstName = currentUser.firstName
            let lastName = currentUser.lastName
            let cardNumber = currentUser.bankCard.cardNumber
            let csvNumber = currentUser.bankCard.csvNumber
            let expDate = currentUser.bankCard.expiryDate
            self.ref.child("users").child(userID!).setValue(["licensePlate": licensePlate,
                                                        "firstName": firstName,
                                                        "lastName": lastName,
                                                        "cardNumber": cardNumber,
                                                        "csvNumber": csvNumber,
                                                        "expDate": expDate,
                                                        "parkingID": parkingID])
        }
    }
}
