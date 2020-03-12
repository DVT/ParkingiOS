//
//  GridUI.swift
//  ParkIt
//
//  Created by Akshar Madanlal on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

extension ParkingSpot {
    var levelView: Int {
        get {
            switch level{
            case .ground: return 0
            case .levelOne: return 1
            }
        }
    }
}


class GridUI: UIViewController {
  @IBOutlet weak var LeftStack: UIStackView!
  @IBOutlet weak var RightStack: UIStackView!
    
    var imageArray: [UIImageView] = []
    
    private func prepareImageStacks() {
            imageArray.append(imge0)
            imageArray.append(imge1)
            imageArray.append(imge2)
            imageArray.append(imge3)
            imageArray.append(imge4)
            imageArray.append(imge5)
            imageArray.append(imge6)
            imageArray.append(imge7)
            imageArray.append(imge8)
            imageArray.append(imge9)
    }
        
    @IBOutlet weak var imge9: UIImageView!
    @IBOutlet weak var imge8: UIImageView!
    @IBOutlet weak var imge7: UIImageView!
    @IBOutlet weak var imge6: UIImageView!
    @IBOutlet weak var imge5: UIImageView!
    @IBOutlet weak var imge0: UIImageView!
    @IBOutlet weak var imge1: UIImageView!
    @IBOutlet weak var imge2: UIImageView!
    @IBOutlet weak var imge3: UIImageView!
    @IBOutlet weak var imge4: UIImageView!
    var parkingSpaces = [ParkingSpot]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.view
        prepareImageStacks()
//      this will change when the array reccieved
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .disabled, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .vacant))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))
      parkingSpaces.append(ParkingSpot.init(level: .ground, type: .normal, status: .occupied))

        for (index, parkingSpot) in parkingSpaces.enumerated() {
            switch parkingSpot.type {
                case .disabled: //imageArray[index].backgroundColor = .systemYellow
                imageArray[index].image = UIImage(named: "disabled_icon.png")
                case .normal: imageArray[index].backgroundColor = .none
            }
            switch parkingSpot.status {
                case .occupied: imageArray[index].image = UIImage(named: index < 5 ? "car_icon1.png" : "car_icon2.png")
                case .vacant: imageArray[index].image = imageArray[index].image
            }
        }
    }
}
