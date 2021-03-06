//
//  ViewController.swift
//  ParkIt
//
//  Created by Brandon Gouws on 2020/03/09.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  @IBAction func Park(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "GridStoryboard", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "GridUI") as UIViewController
    present(vc, animated: true, completion: nil)
  }
    @IBAction func btnPaymentScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PaymentStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentPayScreenView") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    @IBAction func btn_WelcomeScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WelcomeBoard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    @IBAction func dashboardButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DashboardStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController
        present(vc, animated: true, completion: nil)
    }
  
  @IBAction func btnParkingDuration(_ sender: Any) {
    
    let storyboard = UIStoryboard(name: "ParkingDuration", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ParkingDurationViewController") as? ParkingDurationViewController
    
    if let viewController = vc {
      
      viewController.parkingLevel = ParkingFloor(level: .ground, info: "Info", rate: 17.00, parkingDetails: "Details", parkingSpots: [], stores: "Spar", "Pick 'n Pay")
      present(viewController, animated: true, completion: nil)
    }
    
  }
    
    //Logging in dummy user
    @IBOutlet weak var lblVacant: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myAccount = AccountManagement()
        myAccount.signInUser(email: "brandongouws100@gmail.com", password: "happydays") { (success) in
            if success {
                print("User successfully signed in")
            } else {
                print("Unsuccessful Sign in")
            }
        }
    }
}
