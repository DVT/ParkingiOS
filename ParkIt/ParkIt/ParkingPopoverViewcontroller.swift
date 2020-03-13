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
  public var spot: ParkingSpot? //this will be assigned when the view is called
  
  override func viewDidLoad() {
        super.viewDidLoad()
//    var ids = String(parkingID)
//    PSpotLabel.text = String(ids)
    PStatusLabel.text = spot?.status.rawValue
    PTypeLabel.text = spot?.type.rawValue
    PLevelLabel.text = spot?.level.rawValue
    PRateLabel.text = "Loading..."
    PShopsLabel.text = "Loading..."
  }
  
  override func viewDidAppear(_ animated: Bool) {
    <#code#>
  }
  
  
}
