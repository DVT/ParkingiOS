//
//  GridUI.swift
//  ParkIt
//
//  Created by Akshar Madanlal on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class GridUI: UIViewController {
  @IBOutlet weak var LeftStack: UIStackView!
  @IBOutlet weak var RightStack: UIStackView!
  var parkingSpaces = [ParkingSpot]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
//      this will change when the array reccieved
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))
 
      var counter = 0
      for spot in parkingSpaces {
        if (counter<5) {
          let iconName = selecticontodisplay(spot: spot)
          let image = UIImageView(image: UIImage(named: iconName))
          if (spot.type == .disabled) {
            image.backgroundColor = UIColor.brown
          }
          image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
           LeftStack.addArrangedSubview(image)
        } else if (counter>4 && counter<parkingSpaces.count) {
           let iconName = selecticontodisplay(spot: spot)
          let image = UIImageView(image: UIImage(named: iconName))
          if (spot.type == .disabled) {
//            this is for disables parking spaces.
            image.backgroundColor = UIColor.brown
          }
          image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
          RightStack.addArrangedSubview(image)
        }
        counter = counter + 1
      }
      
    }
  public func selecticontodisplay(spot: ParkingSpot) -> String {
    var icon: String = ""
    if (spot.status == .occupied) {
      icon = "car_icon1.png"
    } else if(spot.status == .vacant) {
       icon = "open_space_icon.png"
    }
    return icon
  }

}
