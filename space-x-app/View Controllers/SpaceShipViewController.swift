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
    lazy private(set) var viewModel = SpaceShipViewModel(apiClient: ApiClient.shared, delegate: self)
    
    private let userDefaultsStorage = UserDefaultsStorage(defaults: UserDefaults.standard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spaceShipTableView.delegate = self
        self.spaceShipTableView.dataSource = self
        self.viewModel.fetchShips()
    }
    
    // MARK: Actions
    @IBAction func filterButton(_ sender: Any) {
        self.showActionSheet()
    }
    @IBAction func resetFilterButton(_ sender: Any) {
        self.showResetActionSheet()
    }
}

extension SpaceShipViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.fetchedShips.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell {
            cell.configSpaceShipCell(spaceShip: self.viewModel.fetchedShips[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = mainStoryboard.instantiateViewController(identifier: "MissionDetailViewController") as? MissionDetailViewController {
            detailViewController.selectedSpaceShip = self.viewModel.fetchedShips[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SpaceShipViewController {
    // MARK: Action Sheets
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
}

extension SpaceShipViewController {
    // MARK: Filtering Methods
    func filterShipsByMissionName() {
        self.viewModel.fetchedShips = self.viewModel.fetchedShips.sorted(by: { $0.missionName < $1.missionName })
        self.userDefaultsStorage.saveFilter(
            value: UserDefaultsStorage.FilterValues.byMissionName.rawValue,
            key: self.userDefaultsStorage.filterKey
        )
        self.spaceShipTableView.reloadData()
    }
    
    func filterShipsByLaunchYear() {
        self.viewModel.fetchedShips = self.viewModel.storedShipsData
        self.viewModel.fetchedShips = self.viewModel.fetchedShips.sorted(by: { $0.launchYear < $1.launchYear })
        self.userDefaultsStorage.saveFilter(
            value: UserDefaultsStorage.FilterValues.byLaunchYear.rawValue,
            key: self.userDefaultsStorage.filterKey
        )
        self.spaceShipTableView.reloadData()
    }
    
    func resetFilter() {
        self.viewModel.fetchedShips = self.viewModel.storedShipsData
        self.userDefaultsStorage.saveFilter(
            value: UserDefaultsStorage.FilterValues.defaultState.rawValue,
            key: self.userDefaultsStorage.filterKey
        )
        self.spaceShipTableView.reloadData()
    }
}

//MARK: SpaceShipViewModelDelegate

extension SpaceShipViewController: SpaceShipViewModelDelegate {

    func refreshData() {
        if let filter = self.userDefaultsStorage.getFilter(key: userDefaultsStorage.filterKey) {
            print(filter)
            switch filter {
            case UserDefaultsStorage.FilterValues.byMissionName.rawValue:
                filterShipsByMissionName()
            case UserDefaultsStorage.FilterValues.byLaunchYear.rawValue:
                filterShipsByLaunchYear()
            case UserDefaultsStorage.FilterValues.defaultState.rawValue:
                self.spaceShipTableView.reloadData()
            default:
                self.spaceShipTableView.reloadData()
            }
        } else {
            self.spaceShipTableView.reloadData()
        }
    }

    func showAlert(message: String?) {
        let alertMessage = message ?? "Default"
        let alert = UIAlertController(
            title: "Error",
            message: alertMessage,
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

    // MARK: Spinner Methods
    func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: spaceShipTableView, animated: true)
        hud.label.text = "Loading..."
    }

    func hideLoadingHUD() {
        MBProgressHUD.hide(for: spaceShipTableView, animated: true)
    }
}
