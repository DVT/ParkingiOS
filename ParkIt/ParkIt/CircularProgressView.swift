//
//  CircularProgressView.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class CircularProgressView: UIView, CAAnimationDelegate {
  
  private var progressLayer = CAShapeLayer()
  private var trackLayer = CAShapeLayer()
  private(set) var currentProgress: Float = 0.0
  var resetWhenDone = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    createCircularPath()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    createCircularPath()
  }
  
  var progressColor: UIColor = UIColor.white {
    
    didSet {
      progressLayer.strokeColor = progressColor.cgColor
    }
    
  }
  
  var trackColor: UIColor = UIColor.black {
    
    didSet {
      trackLayer.strokeColor = trackColor.cgColor
    }
    
  }
  
  private func createCircularPath() {
    
    self.backgroundColor = UIColor.clear
    self.layer.cornerRadius = self.frame.size.width/2
    
    let arcCenter = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
    let radius = (frame.size.width - 1.5)/2
    let startAngle = CGFloat(-0.5 * .pi)
    let endAngle = CGFloat(1.5 * .pi)
    
    let circlePath = UIBezierPath(arcCenter: arcCenter,
                                  radius: radius,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: true)
    
    setUpTrackLayer(with: circlePath)
    setUpProgressLayer(with: circlePath)
    
  }
  
  private func setUpTrackLayer(with circlePath: UIBezierPath) {
    
    trackLayer.path = circlePath.cgPath
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.strokeColor = trackColor.cgColor
    trackLayer.lineWidth = 15.0
    trackLayer.strokeEnd = 1.0
    self.layer.addSublayer(trackLayer)
    
  }
  
  private func setUpProgressLayer(with circlePath: UIBezierPath) {
    
    progressLayer.path = circlePath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = progressColor.cgColor
    progressLayer.lineWidth = 15.0
    progressLayer.strokeEnd = 0.0
    self.layer.addSublayer(progressLayer)
    
  }
  
  private func checkIfCanReset() {
    
    if (resetWhenDone) && (currentProgress >= 1) {
      resetProgressToZero()
    }
    
  }
  
  func setProgressWithAnimation(duration: TimeInterval, value: Float) {
    
    currentProgress = value
    
    CATransaction.begin()
    CATransaction.setCompletionBlock({ [weak self] in
      self?.checkIfCanReset()
    })
    
    let animation = CABasicAnimation (keyPath: "strokeEnd")
    animation.duration = duration - 0.05
    animation.fromValue = 0.0
    animation.toValue = currentProgress
    animation.timingFunction = CAMediaTimingFunction (name: .linear)
    
    progressLayer.strokeEnd = CGFloat(currentProgress)
    progressLayer.add(animation, forKey: "animate_progress")
    
    CATransaction.commit()
    
  }
  
  func resetProgressToZero() {
    currentProgress = 0
    
    let animation = CABasicAnimation (keyPath: "strokeEnd")
    animation.duration = 0
    animation.fromValue = 0
    animation.toValue = 0
    animation.timingFunction = CAMediaTimingFunction (name: .default)
    
    progressLayer.strokeEnd = CGFloat(currentProgress)
    progressLayer.add(animation, forKey: "animate_reset")
  }
  
  func addToProgress(add value: Float, duration: TimeInterval) {
    
    CATransaction.begin()
    CATransaction.setCompletionBlock({ [weak self] in
      self?.checkIfCanReset()
    })
    
    let animation = CABasicAnimation (keyPath: "strokeEnd")
    animation.duration = duration - 0.05
    animation.fromValue = currentProgress
    currentProgress += value
    animation.toValue = currentProgress
    animation.timingFunction = CAMediaTimingFunction (name: .linear)
    
    progressLayer.strokeEnd = CGFloat(currentProgress)
    progressLayer.add(animation, forKey: "animate_add_progress")
    
    CATransaction.commit()
    
  }
  
}
