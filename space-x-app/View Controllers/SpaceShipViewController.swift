//
//  SpaceShipViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 05/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class SpaceShipViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var spaceShipTableView: UITableView!
    
    // MARK: Variables and Constants
    var fetchedShips = [SpaceShip]()
    var storedShipsData = [SpaceShip]()
    private let apiClient = ApiClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spaceShipTableView.delegate = self
        spaceShipTableView.dataSource = self
        fetchShips()
    }
    
    // MARK: Actions
    @IBAction func filterButton(_ sender: Any) {
        self.showActionSheet()
    }
    @IBAction func resetFilterButton(_ sender: Any) {
        self.showResetActionSheet()
    }
    
    // MARK: Methods
    func fetchShips() {
        self.showLoadingHUD()
        apiClient.fetchShips(
            completionHandler: { (result, error) in
                self.hideLoadingHUD()
                guard let result = result else {
                    self.showAlert(message: error?.getSpaceErrorString())
                    return
                }
                self.fetchedShips = result
                self.storedShipsData = self.fetchedShips
                self.spaceShipTableView.reloadData()
            }
        )
    }
}

extension SpaceShipViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedShips.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell {
            cell.configSpaceShipCell(spaceShip: fetchedShips[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = mainStoryboard.instantiateViewController(identifier: "MissionDetailViewController") as? MissionDetailViewController {
            detailViewController.selectedSpaceShip = fetchedShips[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SpaceShipViewController {
    // MARK: Alerts and Action Sheets
    func showAlert(message: String?) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "Close",
            style: .cancel,
            handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }
        ))
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(
            title: "Space Ships filter",
            message: "You can filter Ships with following parameters",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(
            title: "By Mission name",
            style: .default,
            handler: { _ in
                self.filterShipsByMissionName()
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "By Launch Year",
            style: .default,
            handler: { _ in
                self.filterShipsByLaunchYear()
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
                actionSheet.dismiss(animated: true, completion: nil)
            }
        ))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showResetActionSheet() {
        let actionSheet = UIAlertController(
            title: "Reset filter",
            message: "You can reset filter for Ships",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(
            title: "Reset",
            style: .default,
            handler: { _ in
                self.resetFilter()
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
                actionSheet.dismiss(animated: true, completion: nil)
            }
        ))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: Spinner Methods
    func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: spaceShipTableView, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hide(for: spaceShipTableView, animated: true)
    }
}

extension SpaceShipViewController {
    // MARK: Filtering Methods
    func filterShipsByMissionName() {
        self.fetchedShips = fetchedShips.sorted(by: { $0.missionName < $1.missionName })
        self.spaceShipTableView.reloadData()
    }
    
    func filterShipsByLaunchYear() {
        self.fetchedShips = storedShipsData
        self.fetchedShips = fetchedShips.sorted(by: { $0.launchYear < $1.launchYear })
        self.spaceShipTableView.reloadData()
    }
    
    func resetFilter() {
        self.fetchedShips = storedShipsData
        self.spaceShipTableView.reloadData()
    }
}
