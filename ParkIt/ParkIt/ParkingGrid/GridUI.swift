//
//  GridUI.swift
//  ParkIt
//
//  Created by Akshar Madanlal on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
extension ParkingSpot {
    var levelView: Int {
        get {
            switch level{
            case .ground: return 0
            case .levelOne: return 1
            }
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}


class GridUI: UIViewController {
  @IBOutlet weak var LeftStack: UIStackView!
  @IBOutlet weak var RightStack: UIStackView!
  var parkingSpaces = [ParkingSpot]()
  var parkTimer: Timer?
    
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
                case .family: imageArray[index].backgroundColor = .systemGreen
            }
            switch parkingSpot.status {
                case .occupied: imageArray[index].image = UIImage(named: index < 5 ? "car_icon1.png" : "car_icon2.png")
                case .vacant: imageArray[index].image = imageArray[index].image
            }
    }
  override func viewDidAppear(_ animated: Bool) {
    //    this line runs the runTimedCode function continuously
    runTimedCode()
    parkTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
  }
  
  @objc func runTimedCode() {
    let myFire = FirebaseRetrieveData()
      myFire.getData(parkingLevel: "Level0") { (parking) in
      self.parkingSpaces = parking
        DispatchQueue.main.async {
           var counter = 0
        for spot in self.parkingSpaces {
//          bug for view, empty the stackviews everytime the function is called
          if counter < 2 {
                  let iconName = self.selecticontodisplay(spot: spot)
                  let image = UIImageView(image: UIImage(named: iconName))
                  if (spot.type == .disabled) {
                    image.backgroundColor = UIColor.brown
                  }
                  image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.LeftStack.insertArrangedSubview(image, at: counter)
          } else if (counter > 1) && (counter < self.parkingSpaces.count) {
              let iconName = self.selecticontodisplay(spot: spot)
              let image = UIImageView(image: UIImage(named: iconName))
              if (spot.type == .disabled) {
    //            this is for disables parking spaces.
                image.backgroundColor = UIColor.brown
              }
              image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
              self.RightStack.insertArrangedSubview(image, at: (counter-2))
            }
          counter = counter + 1
          print(counter)
        }
    }
}
