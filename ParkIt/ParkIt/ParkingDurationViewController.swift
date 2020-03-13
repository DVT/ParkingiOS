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
  private var timer: Timer?
  var parkingLevel: ParkingFloor?
  private var runCount = 0
  
  override func viewDidLoad() {
      super.viewDidLoad()

    lblCost.text = "R 0.00"
    lblPlace.text = parkingLevel?.level.rawValue
    parkingSpotBecameOccupied()
    
  }
  
  @IBAction func btnDonePressed(_ sender: Any) {
    
    parkingSpotBecameUnoccupied()
    
  }
  
  private func incrementTime() {
    
    let minutes = runCount % 60
    let hours = Int(floor(Double(runCount)/60.0))
    
    let labelContent = "\(hours):\(minutes)"
    lblTime.text = labelContent
    
    updateCost()
    
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
    
    runCount = 0
    
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
      
      guard let self = self else {
        return
      }
      
      if self.runCount >= 120 {
        timer.invalidate()
        return
      }
      
      self.circularView?.addToProgress(add: (1/60), duration: 1.0)
      
      self.runCount += 1
      
      self.incrementTime()
      
    }
    
  }
  
  private func updateCost() {
    
    let hours = floor(Double(runCount)/60)
    
    guard hours >= 1 else {
      return
    }
    
    let costContent = "R\(hours * (parkingLevel?.rate ?? 1.00))"
    
    lblCost.text = costContent
    
  }
  
  private func navigateToPaymentStoryboard(rate: Double?, hours: Int) {
    
    let storyboard = UIStoryboard(name: "PaymentStoryboard", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "PaymentPayScreenView") as? PaymentPayScreenView
    
    if let viewController = vc {
      
      viewController.hour = hours
      viewController.rate = rate
      present(viewController, animated: true, completion: nil)
    }
    
  }
  
}

extension ParkingDurationViewController: ParkingStatusObserver {
  
  func parkingSpotBecameOccupied() {
    
    if let view = self.view.viewWithTag(10) {
      setUpCircularProgressView(in: view, lasting: 90)
    }
    
  }
  
  func parkingSpotBecameUnoccupied() {
    
    timer?.invalidate()
    let hours = Int(floor(Double(runCount)/60.0))
    
    navigateToPaymentStoryboard(rate: parkingLevel?.rate, hours: hours)
    
  }
  
}
