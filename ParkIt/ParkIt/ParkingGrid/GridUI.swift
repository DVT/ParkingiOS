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
  var gameTimer: Timer?
  
    override func viewDidLoad() {
        super.viewDidLoad()
//      this will change when the array reccieved
      
    }
  
  override func viewDidAppear(_ animated: Bool) {
//    this line runs the runTimedCode function continuously
    gameTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
  }
  @objc func runTimedCode() {
    let myFire = FirebaseRetrieveData()
      myFire.getData(parkingLevel: "Level0") { (parking) in
      self.parkingSpaces = parking
      DispatchQueue.main.async {
       var counter = 0
        for spot in self.parkingSpaces {
          if (counter<(self.parkingSpaces.count/2)) {
                  let iconName = self.selecticontodisplay(spot: spot)
                  let image = UIImageView(image: UIImage(named: iconName))
                  if (spot.type == .disabled) {
                    image.backgroundColor = UIColor.brown
                  }
                  image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                  self.LeftStack.addArrangedSubview(image)
          } else if (counter>((self.parkingSpaces.count/2)-1) && counter<self.parkingSpaces.count) {
                  let iconName = self.selecticontodisplay(spot: spot)
                  let image = UIImageView(image: UIImage(named: iconName))
                  if (spot.type == .disabled) {
        //            this is for disables parking spaces.
                    image.backgroundColor = UIColor.brown
                  }
                  image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                  self.RightStack.addArrangedSubview(image)
                }
                counter = counter + 1
              }
      }
    }
  }
  
//  WE WILL NEED TO DEINITIALISE THE TIMER WHEN WE MOVE TO ANOTHER AREA WITH: gameTimer?.invalidate()
//
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
