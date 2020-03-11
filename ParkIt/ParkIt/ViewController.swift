//
//  ViewController.swift
//  ParkIt
//
//  Created by Brandon Gouws on 2020/03/09.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBAction func Park(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "GridStoryboard", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "GridUI") as UIViewController
    present(vc, animated: true, completion: nil)
  }
  
    @IBAction func btn_WelcomeScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WelcomeBoard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
