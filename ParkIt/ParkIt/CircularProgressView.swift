//
//  CircularProgressView.swift
//  ParkIt
//
//  Created by Tiewhan Smith on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
  
  private var progressLayer = CAShapeLayer()
  private var trackLayer = CAShapeLayer()
  
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
    
    trackLayer.path = circlePath.cgPath
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.strokeColor = trackColor.cgColor
    trackLayer.lineWidth = 10.0
    trackLayer.strokeEnd = 1.0
    layer.addSublayer(trackLayer)
    
    progressLayer.path = circlePath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = progressColor.cgColor
    progressLayer.lineWidth = 10.0
    progressLayer.strokeEnd = 0.0
    layer.addSublayer(progressLayer)
    
  }
  
}
