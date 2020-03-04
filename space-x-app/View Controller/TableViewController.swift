//
//  ViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class TableViewController: UITableViewController {
    var ships: [SpaceShip] = []
    private let apiClient = ApiClient.shared
    let defaultError = ApiClient.DefaultError.defaultError

    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.fetchShips { (result, error) in
            guard let result = result else {
                self.showAlert(message: self.apiClient.mapErrorFrom(error: error ?? self.defaultError).rawValue)
                return
            }
            self.ships = result
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ships.count
//        return ships.count - 103
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell {
            cell.configSpaceShipCell(spaceShip: ships[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = mainStoryboard.instantiateViewController(identifier: "MissionDetailViewController") as? MissionDetailViewController {
            detailViewController.selectedSpaceShip = ships[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewController {
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
