//
//  PaymentPayScreenView.swift
//  ParkIt
//
//  Created by Xander Schoeman on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class PaymentPayScreenView: UIViewController {

    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblParkingNum: UILabel!
    @IBOutlet weak var lblHourlyRate: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var lblCardNum: UILabel!
    @IBOutlet weak var lblLicensePlate: UILabel!
    
    @IBAction func btnMakePayment(_ sender: UIButton) {
    displayDefaultAlert(title: "Success", message: "Your parking has been reserved!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var accountObj = AccountManagement()
        accountObj.signInUser(email: "brandongouws100@gmail.com", password: "happydays") { (success) in
            if success {
                print("User successfully signed in")
                accountObj.getUser { (success, user) in
                    
                    let name = user.bankCard.cardNumber
                    let conditionIndex = name.count - 3
                    let maskedName = String(name.enumerated().map { (index, element) -> Character in
                        return index < conditionIndex ? "x" : element
                    })
                    print("Masked Name: ", maskedName)//testing
                    
                     var fullname = "\(user.firstName)  \(user.lastName)"
                     self.lblCustomerName.text = fullname
                    self.lblParkingNum.text = ""
                    self.lblHourlyRate.text = "15"
                    self.lblDuration.text = "15"
                    let hourRate = Int(self.lblHourlyRate.text ?? "0")
                    let duration = Int(self.lblDuration.text ?? "0")
                    
                    self.lblPriceTotal.text = String(hourRate!*duration!)
                    self.lblLicensePlate.text = user.licensePlateNum
                    self.lblCardNum.text = maskedName
                     
                     
                 }
            } else {
                print("Unsuccessful Sign in")
            }
        }
 

    }
    

    
    func displayDefaultAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    
    
}
