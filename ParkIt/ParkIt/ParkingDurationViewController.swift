//
//  ParkingDurationViewController.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ParkingDurationViewController: UIViewController {

  @IBOutlet weak var lblPlace: UILabel!
  @IBOutlet weak var lblCost: UILabel!
  @IBOutlet weak var lblTime: UILabel!
  
  private var circularView: CircularProgressView?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      if let view = self.view.viewWithTag(10) {
        setUpCircularProgressView(in: view, lasting: 90)
      }
      
    }
  
  private func incrementTime(runCount: Int) {
    
    let minutes = runCount % 60
    let hours = Int(floor(Double(runCount)/60.0))
    
    let labelContent = "\(hours):\(minutes)"
    lblTime.text = labelContent
    
  }
  
  private func setUpCircularProgressView(in parentView: UIView, lasting duration:Int) {
    
    circularView = CircularProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 230.0, height: 230.0))
    
    guard let circularView = circularView else {
      return
    }
    
    circularView.trackColor = ColourTheme.Palette.primaryPurple ?? .red
    circularView.progressColor = ColourTheme.Palette.secondaryPurple ?? .blue
    
    parentView.backgroundColor = .white
    parentView.addSubview(circularView)
    
    circularView.center = parentView.center
    circularView.resetWhenDone = true
    
    var runCount = 0
    
    let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
      
      if runCount >= 120 {
        timer.invalidate()
        return
      }
      
      self.circularView?.addToProgress(add: (1/60), duration: 1.0)
      
      runCount += 1
      
      self.incrementTime(runCount: runCount)
      
      
      
    }
    
  }
  
}
