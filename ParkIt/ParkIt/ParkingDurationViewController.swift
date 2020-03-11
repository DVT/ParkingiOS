//
//  ParkingDurationViewController.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ParkingDurationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      let circularView = CircularProgressView(frame: CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0))
      circularView.trackColor = .red
      circularView.progressColor = .blue
      
      self.view.addSubview(circularView)
      
    }
    
}
