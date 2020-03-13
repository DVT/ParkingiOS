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
  var parkingfloor: ParkingFloor?
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
    @IBOutlet weak var actLoader: UIActivityIndicatorView!
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
        let transfrom = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        actLoader.transform = transfrom
      
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
            if (self.actLoader.isAnimating){
                self.actLoader.hidesWhenStopped = true
                self.actLoader.stopAnimating()
            }
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
        }
    }
}
      
    @IBAction func btnBook(_ sender: Any) {
        parkTimer?.invalidate()
      
      let storyboard = UIStoryboard(name: "PopoverView", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "ParkingPopoverViewController") as? ParkingPopoverViewController
       let myFire = FirebaseRetrieveData()
      myFire.getInformation(parkingSpotLevel: self.parkingSpaces[selectedIndex].level, parkingSpots: parkingSpaces) { (pf) in
      self.parkingfloor = pf
        DispatchQueue.main.async {
          if let viewC = vc {
            viewC.parkingID = self.selectedIndex
            viewC.spotdetails = self.parkingfloor
            self.present(viewC, animated: true, completion: nil)
          }
        }
    }
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
        selectedIndex = index ?? -1
        if (parkingSpaces.count <= selectedIndex || parkingSpaces[selectedIndex].status == ParkingSpotStatus.occupied || parkingSpaces[selectedIndex].status == .occupied) {
            lblSelection.text = "That parking is not available"
            return
        }
        
        tappedImage.image = UIImage(named: "car_selected.png")
        lblSelection.text = "You selected L\(parkingSpaces[selectedIndex].levelView):P\(selectedIndex)"
        btnBook.isEnabled = true
        btnBook.backgroundColor = ColourTheme.Palette.primaryPurple
    }
    
    
}
