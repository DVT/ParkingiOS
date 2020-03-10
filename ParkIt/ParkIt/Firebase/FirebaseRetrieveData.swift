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
    
    func getData(parkingLevel: String,completion: @escaping (_ val: [String]) -> ()) {
        var parking = [String]()
        ref.child("Parking").child(parkingLevel).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
            let snap = child as! DataSnapshot
            let key = snap.key
            let val = snap.value
            parking.append("\(key):\(val!)")
            }
            completion(parking)
        }
    }
}
