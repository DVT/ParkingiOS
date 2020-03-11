//
//  PaymentPayScreenView.swift
//  ParkIt
//
//  Created by Xander Schoeman on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class PaymentPayScreenView: UIViewController {

    @IBOutlet weak var txtCardNumber: UITextField!
    
    @IBOutlet weak var txtCSVNumber: UITextField!
    
    @IBOutlet weak var lblPriceAmount: UILabel!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var lblTimeValue: UILabel!

    @IBAction func timeStepper(_ sender: UIStepper) {
        lblTimeValue.text = String(sender.value)
        
        switch lblTimeValue.text {
        case "0.0":
            lblPriceAmount.text = "R0.00"
        case "1.0":
            lblPriceAmount.text = "R15.00"
        case "2.0":
            lblPriceAmount.text = "R35.00"
        case "3.0":
            lblPriceAmount.text = "R60.00"
        default:
            lblPriceAmount.text = "R0.00"
            
        }

    }
    
    @IBAction func btnReserve(_ sender: Any) {
        //var bankCardObj = GetBankObj(cardnumber: <#T##String#>, csvnumber: <#T##String#>, expirydate: <#T##String#>)
        displayDefaultAlert(title: "Success", message: "Your parking has been reserved!")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GetBankObj(cardnumber: txtCardNumber.text ?? "Empty", csvnumber: txtCSVNumber.text ?? "Empty", expirydate: txtExpiryDate.text ?? "Empty")
        
    }
    
    func GetBankObj(cardnumber: String, csvnumber: String, expirydate: String){
        _ = BankCard.init(cardNumber: cardnumber, csvNumber: csvnumber, expiryDate: expirydate, cardCash: 100)
    }
   
    
    func displayDefaultAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    
    
}
