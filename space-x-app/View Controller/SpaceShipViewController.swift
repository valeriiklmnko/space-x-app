//
//  SpaceShipViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 05/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class SpaceShipViewController: UIViewController {
    @IBOutlet weak var spaceShipTableView: UITableView!
    @IBAction func filterButton(_ sender: Any) {
        showActionSheet()
    }
    
    var ships: [SpaceShip] = []
    private let apiClient = ApiClient.shared
    let defaultError = ApiClient.DefaultError.defaultError
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spaceShipTableView.delegate = self
        spaceShipTableView.dataSource = self
        apiClient.fetchShips(
            showLoader: {
                self.showLoadingHUD()
            },
            hideLoader: {
                self.hideLoadingHUD()
            },
            completionHandler: { (result, error) in
            guard let result = result else {
                self.showAlert(message: self.apiClient.mapErrorFrom(error: error ?? self.defaultError).rawValue)
                return
            }
            self.ships = result
            self.spaceShipTableView.reloadData()
        })
    }

}

extension SpaceShipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ships.count
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell {
            cell.configSpaceShipCell(spaceShip: ships[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = mainStoryboard.instantiateViewController(identifier: "MissionDetailViewController") as? MissionDetailViewController {
            detailViewController.selectedSpaceShip = ships[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SpaceShipViewController {
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Space Ships filter", message: "You can filter Ships with following parameters", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "By Mission name", style: .default))
        actionSheet.addAction(UIAlertAction(title: "By Launch Year", style: .default))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: spaceShipTableView, animated: true)
        hud.label.text = "Loading..."
    }

    func hideLoadingHUD() {
        MBProgressHUD.hide(for: spaceShipTableView, animated: true)
    }
}
