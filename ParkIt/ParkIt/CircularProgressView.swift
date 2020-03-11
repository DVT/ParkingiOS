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
  
  var ProgressColor: UIColor = UIColor.white {
    
    didSet {
      progressLayer.strokeColor = ProgressColor.cgColor
    }
    
  }
  
  var TrackColor: UIColor = UIColor.black {
    
    didSet {
      progressLayer.strokeColor = ProgressColor.cgColor
    }
    
  }
  
}
