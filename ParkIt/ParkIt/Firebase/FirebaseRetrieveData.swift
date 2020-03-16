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
    // // // // / // // // // / // // // // // // // // develop version
    func getCurrentState(completion: @escaping (_ val: Int) -> ()) {
        ref.child("ParkingTest").child("Level0").child("P1").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let state = value?["Status"] as? Int ?? 10000
            completion(state)
        }
    }
    
    func getParkingState(parkingLevel: String, parkingNum: String,completion: @escaping (_ val: String) -> ()) {
        ref.child("ParkingTest").child(parkingLevel).child(parkingNum).observe( .childChanged) { (snapshot) in
            self.getCurrentState { (data) in
                completion(String(data))
            }
            completion("Data")
        }
    }
    
    func availableParkingTest(completion: @escaping (_ val: Int) -> ()) {
        ref.child("ParkingTest").child("Level0").observe(.childChanged) { (snapshot) in
            self.getNumAvailableParkingTest { (vacant) in
                completion(vacant)
            }
        }
        ref.child("ParkingTest").child("Level1").observe(.childChanged) { (snapshot) in
            self.getNumAvailableParkingTest { (vacant) in
                completion(vacant)
            }
        }
    }
    func getNumAvailableParkingTest(completion: @escaping (_ val: Int) -> ()) {
        self.getLevelCount { (count) in
            var vacantTotal = 0
            for child in 0 ... count-1 {
                let parkingLevel: String = "Level\(child)"
                for parkings in 1 ... 5 {
                    self.ref.child("ParkingTest").child(parkingLevel).child("P\(parkings)").observeSingleEvent(of: .value) { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let state = value?["Status"] as? Int ?? 1000
                        //Count up avaliable parkings
                        if state == 0 {
                            vacantTotal += 1
                        }
                        completion(vacantTotal)
                    }
                }
                
            }
        }
    }
    func getData(parkingLevel: String, _ completion: @escaping (_ val: [ParkingSpot]) -> ()) {
        ref.child("ParkingTest").child(parkingLevel).observeSingleEvent(of: .value) { (snapshot) in
            for item in 1...5 {
                self.ref.child("ParkingTest").child(parkingLevel).child("P\(item)").observeSingleEvent(of: .value) { (snapshot) in
                    let value =  snapshot.value as? NSDictionary
                    let ID = value?["ID"] as?  Int ?? 1000
                    let Status = value?["Status"] as?  Int ?? 1000
                    let Type = value?["Type"] as?  String ?? ""
                    let parkingType: ParkingSpotType
                    switch Type {
                    case "Disability":
                        parkingType = .disabled
                    case "Normal":
                        parkingType = .normal
                    case "Family":
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
                    
                    switch Status {
                    case 0:
                        parkingSpotStatus = .vacant
                    case 1:
                        parkingSpotStatus = .occupied
                    default:
                        parkingSpotStatus = .occupied
                    }
                    let parkingSpot = ParkingSpot(level: parkingSpotLevel, type: parkingType, status: parkingSpotStatus, parkingID: String (ID))
                    self.parkingSpots.append(parkingSpot)
                    if item >= 5 {
                        completion(self.parkingSpots)
                    }
                }
            }
        }
    }
    // // // // // // // // // // // // // // // // // // // // // // // //
    
    func getDatax(parkingLevel: String,completion: @escaping (_ val: [ParkingSpot]) -> ()) {
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
    func getInformation(parkingSpotLevel: ParkingSpotLevel, parkingSpots: [ParkingSpot], completion: @escaping (_ val: ParkingFloor) -> ()) {
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
            let parkingFloor = ParkingFloor(level: parkingSpotLevel, info: info, rate: Double(rate), parkingDetails: parkingDetails, stores: allStores, parkingSpots: parkingSpots)
            completion(parkingFloor)
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
