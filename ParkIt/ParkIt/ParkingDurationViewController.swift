//
//  ParkingDurationViewController.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ParkingDurationViewController: UIViewController {

  private var circularView: CircularProgressView?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      setUpCircularProgressView()
      
    }
  
  func setUpCircularProgressView() {
    
    guard var circularView = circularView else {
      return
    }
    
    circularView = CircularProgressView(frame: CGRect(x: 10.0, y: 10.0, width: 250.0, height: 250.0))
    circularView.trackColor = ColourTheme.Palette.primaryPurple ?? .red
    circularView.progressColor = ColourTheme.Palette.secondaryPurple ?? .blue
    
    self.view.addSubview(circularView)
    
    circularView.center = self.view.center
    circularView.resetWhenDone = true
    
    var runCount = 0
    
    let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
      
      self.circularView?.addToProgress(add: (1/60), duration: 1.0)
      
      runCount += 1
      
      if runCount >= 120 {
        timer.invalidate()
      }
      
    }
    
  }
  
}
