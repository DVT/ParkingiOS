//
//  GridUI.swift
//  ParkIt
//
//  Created by Akshar Madanlal on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

public struct space {
  public var id: Int
  public var state: String
  
  public init(id: Int, state: String) {
    self.id = id
    self.state = state
  }
}

class GridUI: UIViewController {
  @IBOutlet weak var LeftStack: UIStackView!
  @IBOutlet weak var RightStack: UIStackView!
  let numberofspaces = 5
  var spaces = [space]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      spaces.append(space(id: 0, state: "reserved"))
      spaces.append(space(id: 1, state: "open"))
      spaces.append(space(id: 2, state: "taken"))
      spaces.append(space(id: 3, state: "taken"))
      spaces.append(space(id: 4, state: "open"))
      spaces.append(space(id: 5, state: "taken"))
      spaces.append(space(id: 6, state: "taken"))
      spaces.append(space(id: 7, state: "open"))
      spaces.append(space(id: 8, state: "open"))
      spaces.append(space(id: 9, state: "reserved"))
      
      for spot in spaces {
        if (spot.id<5) {
          let iconName = iconselection(state: spot.state)
          let image = UIImageView(image: UIImage(named: iconName))
          image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
           LeftStack.addArrangedSubview(image)
        } else if (spot.id>4 && spot.id<10) {
           let iconName = iconselection(state: spot.state)
          let image = UIImageView(image: UIImage(named: iconName))
          image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
          RightStack.addArrangedSubview(image)
        }
      }
    }
  
  public func iconselection(state: String) -> String {
    var icon: String = ""
    if (state == "reserved") {
      icon = "reserved_space_icon.jpeg"
    } else if (state == "open") {
      icon = "open_space_icon.png"
    } else if (state == "taken") {
      icon = "car_icon1.png"
    }
    return icon
  }

}
