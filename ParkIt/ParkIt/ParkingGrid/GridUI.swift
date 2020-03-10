//
//  GridUI.swift
//  ParkIt
//
//  Created by Akshar Madanlal on 2020/03/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit

class GridUI: UIViewController {
  @IBOutlet weak var LeftStack: UIStackView!
  @IBOutlet weak var RightStack: UIStackView!
  let numberofspaces = 5
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let image = UIImageView(image: UIImage(named: "car_icon1.png"))
      let image2 = UIImageView(image: UIImage(named: "car_icon1.png"))
      image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
      image2.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
      LeftStack.addArrangedSubview(image)
       LeftStack.addArrangedSubview(image2)
      
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
