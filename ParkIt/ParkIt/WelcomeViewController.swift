//
//  GridUI.swift
//  ParkIt
//
//  Created by Nathan Madanlal on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

//public struct space {
//  public var id: Int
//  public var state: String
//
//  public init(id: Int, state: String) {
//    self.id = id
//    self.state = state
//  }
//}

class WelcomeViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  @IBAction func btnNextClick(_ sender: Any) {
    let storyboard = UIStoryboard(name: "DashboardStoryboard", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as UIViewController
    present(vc, animated: true, completion: nil)
  }
  
}
