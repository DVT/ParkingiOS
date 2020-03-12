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
    var selectedIndex = -1
  @IBOutlet weak var LeftStack: UIStackView!
  @IBOutlet weak var RightStack: UIStackView!
    @IBOutlet weak var lblSelection: UILabel!
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
  @IBOutlet weak var btnBook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.view
      prepareImageStacks()
        helper()
      
  }

  override func viewDidAppear(_ animated: Bool) {
    //    this line runs the runTimedCode function continuously
    runTimedCode()
    parkTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
  }
  
  @objc func runTimedCode() {
    let myFire = FirebaseRetrieveData()
      myFire.getData(parkingLevel: "Level0") { (parking) in
      self.parkingSpaces = parking
        DispatchQueue.main.async {
          for (index,parkingSpot) in self.parkingSpaces.enumerated() {
            if ( index == self.selectedIndex) {
                continue;
            }
          switch parkingSpot.type {
              case .disabled:
                self.imageArray[index].image = UIImage(named: "disabled_icon.png")
              case .normal: self.imageArray[index].backgroundColor = .none
              case .family: self.imageArray[index].backgroundColor = .systemGreen
          }
          switch parkingSpot.status {
              case .occupied: self.imageArray[index].image = UIImage(named: index < 5 ? "car_icon1.png" : "car_icon2.png")
              case .vacant: self.imageArray[index].image = nil
                }
            }
          //  WE WILL NEED TO DEINITIALISE THE TIMER WHEN WE MOVE TO ANOTHER AREA WITH: gameTimer?.invalidate()
        }
    }
}
      
    @IBAction func btnBook(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PopoverView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ParkingPopoverViewController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    func helper() {
        for img in imageArray{
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            img.isUserInteractionEnabled = true
            img.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let index = imageArray.firstIndex(of: tappedImage)
        tappedImage.image = UIImage(named: "car_selected.png")
        selectedIndex = index ?? -1
        if (parkingSpaces.count < selectedIndex || parkingSpaces[selectedIndex].status == ParkingSpotStatus.occupied) {
            lblSelection.text = "That parking is not available"
            return
        }
        lblSelection.text = "You selected L\(parkingSpaces[selectedIndex].levelView):P\(selectedIndex)"
        btnBook.isEnabled = true
        btnBook.backgroundColor = ColourTheme.Palette.primaryPurple
    }
    
    
}
