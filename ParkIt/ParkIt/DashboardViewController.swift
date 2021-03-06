//
//  DashboardViewController.swift
//  ParkIt
//
//  Created by Akua Afrane-Okese on 2020/03/11.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import DropDown
import Firebase

class DashboardViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var data: [String] = ["Rosebank Mall","Sandton City","Reef Mall","Mutula Square","Eastgate Shopping mall","Mall of the South", "Cresta Shopping Centre", "Glen Shopping Centre","Hyde Park Corner","Killarney Mall","Clearwater Mall"]
    var dataFiltered: [String] = []
    var dropButton = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
       dataFiltered = data

        dropButton.anchorView = searchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.backgroundColor = .white
        dropButton.direction = .bottom

        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchBar.text = item
        }
        searchBar.delegate = self
        let myGetData = FirebaseRetrieveData()
        myGetData.availableParking { (vacant) in
            self.locationButton.titleLabel?.text = String(vacant)
        }
        myGetData.getNumAvailableParking { (vacant) in
          self.locationButton.titleLabel?.text = String(vacant)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFiltered = searchText.isEmpty ? data : data.filter({ (dat) -> Bool in
            dat.range(of: searchText, options: .caseInsensitive) != nil
        })

        dropButton.dataSource = dataFiltered
        dropButton.show()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        dataFiltered = data
        dropButton.hide()
    }
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "GridStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GridUI") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
