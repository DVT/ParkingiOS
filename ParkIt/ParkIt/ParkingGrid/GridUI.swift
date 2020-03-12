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
  
    override func viewDidLoad() {
        super.viewDidLoad()
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
  }
//  WE WILL NEED TO DEINITIALISE THE TIMER WHEN WE MOVE TO ANOTHER AREA WITH: gameTimer?.invalidate()

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
