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
                    lastName: String, cardNumber: String, csvNumber: String, expDate: String,completion: @escaping (_ val: Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (result, error) in let success = (error == nil)
            self.saveUserData(licensePlate: licensePlate,firstName: firstName,lastName: lastName,cardNumber: cardNumber, csvNumber: csvNumber, expDate: expDate)
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
    func getUser(completion: @escaping (_ val: Bool, _ CurrentUser: User) -> ()) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print(value!)
            let firstName = value?["firstName"] as? String ?? ""
            let lastName = value?["lastName"] as? String ?? ""
            let licensePlate = value?["licensePlate"] as? String ?? ""
            let cardNumber = value?["cardNumber"] as? String ?? ""
            let csvNumber = value?["csvNumber"] as? String ?? ""
            let expiryDate = value?["expiryDate"] as? String ?? ""
            let userBankCard = BankCard(cardNumber: cardNumber, csvNumber: csvNumber, expiryDate: expiryDate)
            let currentUser = User(licensePlateNum: licensePlate, firstName: firstName, lastName: lastName, bankCard: userBankCard)
            completion(true, currentUser)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    private func saveUserData(licensePlate: String, firstName: String, lastName: String, cardNumber: String, csvNumber: String, expDate: String) {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(userID!).setValue(["licensePlate": licensePlate,
                                                    "firstName": firstName,
                                                    "lastName": lastName,
                                                    "cardNumber": cardNumber,
                                                    "csvNumber": csvNumber,
                                                    "expDate": expDate])
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
