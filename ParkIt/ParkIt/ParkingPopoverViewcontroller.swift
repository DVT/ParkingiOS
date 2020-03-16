//
//  ParkingPopoverViewcontroller.swift
//  ParkIt
//
//  Created by Akshar Madanlal on 2020/03/12.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ParkingPopoverViewController : UIViewController {
  @IBOutlet weak var PSpotLabel: UILabel!
  @IBOutlet weak var PStatusLabel: UILabel!
  @IBOutlet weak var PTypeLabel: UILabel!
  @IBOutlet weak var PLevelLabel: UILabel!
  @IBOutlet weak var PRateLabel: UILabel!
  @IBOutlet weak var PShopsLabel: UILabel!
  public var parkingID: Int?
  public var spotdetails: ParkingFloor?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        PSpotLabel.text = "\((parkingID ?? -1) + 1)"
        PStatusLabel.text = spotdetails?.parkingSpots[parkingID!].status.rawValue
        PTypeLabel.text = spotdetails?.parkingSpots[parkingID!].type.rawValue
        PLevelLabel.text = spotdetails?.parkingSpots[parkingID!].level.rawValue
        PRateLabel.text = "\(spotdetails?.rate ?? 0.0)"
        var shopstores: String = ""
        for s in (spotdetails?.stores)! {
          shopstores.append(s + " , ")
        }
       PShopsLabel.text = shopstores
    
  }
  
  @IBAction func btnDuration(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "ParkingDuration", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ParkingDurationViewController") as! ParkingDurationViewController
    vc.parkingLevel = spotdetails
    present(vc, animated: true, completion: nil)
  }
  
}
