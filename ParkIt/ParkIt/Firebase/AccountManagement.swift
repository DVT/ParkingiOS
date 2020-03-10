//
//  AccountManagement.swift
//  ParkIt
//
//  Created by Brandon Gouws on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AccountManagement {
    func createUser(email: String, password: String,licensePlate: String, firstName: String,
                    lastName: String,completion: @escaping (_ val: Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) {
        (result, error) in let success = (error == nil)
        self.saveUserData(licensePlate: licensePlate,firstName: firstName,lastName: lastName)
        completion(success)
        }
    }
    func signInUser(email: String, password: String, completion: @escaping (_ val: Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) {
        (result, error) in let success = (error == nil)
        completion(success)
        }
    }
    func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
     private func saveUserData(licensePlate: String, firstName: String, lastName: String) {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(userID!).setValue(["licensePlate": licensePlate,
                                                    "firstName": firstName,
                                                    "lastName": lastName])
        {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
}
