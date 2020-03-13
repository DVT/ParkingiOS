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
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var stackLicensePlate: UIStackView!
    @IBOutlet weak var stackCardNumber: UIStackView!
    @IBOutlet weak var lblQRCodeToExit: UILabel!
    @IBOutlet weak var lblThankYou: UILabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    
    var hour: Int?
    var rate: Double?
    
    
    @IBAction func btnConfirmPress(_ sender: Any) {

       lblQRCodeToExit.isEnabled = true
       lblQRCodeToExit.isHidden = false
        lblThankYou.isEnabled = true
        lblThankYou.isHidden = false
       sleep(1)
       displayDefaultAlert(title: "Success", message: "Your parking has been reserved!")
        let imgQRCodeObj = generateQRCode(from: randomString(length: 8) ?? "Error")
        imgQRCode.image = imgQRCodeObj
    }
    
    @IBAction func btnMakePayment(_ sender: UIButton) {
        btnConfirm.isHidden = false
        btnConfirm.isEnabled = true
        lblDetails.isEnabled = true
        lblDetails.isHidden = false
        stackLicensePlate.isHidden = false
        stackCardNumber.isHidden = false

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnConfirm.isEnabled = false
        btnConfirm.isHidden = true
        lblDetails.isEnabled = false
        lblDetails.isHidden = true
        stackLicensePlate.isHidden = true
        stackCardNumber.isHidden = true
        lblQRCodeToExit.isEnabled = false
        lblQRCodeToExit.isHidden = true
        lblThankYou.isEnabled = false
        lblThankYou.isHidden = true
        var accountObj = AccountManagement()
        accountObj.signInUser(email: "brandongouws100@gmail.com", password: "happydays") { (success) in
            if success {
                print("User successfully signed in")
                accountObj.getUser { (success, user) in
                    
                    let name = user.bankCard.cardNumber
                    let conditionIndex = name.count - 3
                    let maskedName = String(name.enumerated().map { (index, element) -> Character in
                        return index < conditionIndex ? "#" : element
                    })
                    print("Masked Name: ", maskedName)//testing
                    
                     var fullname = "\(user.firstName)  \(user.lastName)"
                     self.lblCustomerName.text = fullname
                    self.lblParkingNum.text = String(self.randomParkingNumber(length: 10))
                    self.lblHourlyRate.text = "\(self.rate ?? 0.0)"
                    self.lblDuration.text = "\(self.hour ?? 0)"
                    self.lblLicensePlate.text = user.licensePlateNum
                    self.lblCardNum.text = maskedName
                    let hourRate = Int(self.lblHourlyRate.text ?? "0")
                    let duration = Int(self.lblDuration.text ?? "0")
                    
                    guard let hour = self.hour, let rate = self.rate else {
                        return
                    }
                    
                    self.lblPriceTotal.text = "\(Double(hour) * rate)"

                     
                     
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
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    func randomParkingNumber(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    
    
}
