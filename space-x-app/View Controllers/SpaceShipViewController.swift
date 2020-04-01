//
//  SpaceShipViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 05/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class SpaceShipViewController: BaseViewController {
    
    // MARK: Outlets
    @IBOutlet weak var spaceShipTableView: UITableView!
    
    // MARK: Variables and Constants
    lazy private(set) var viewModel = SpaceShipViewModel(apiClient: ApiClient.shared, delegate: self)
    
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
}

extension SpaceShipViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.fetchedShips.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpaceShipCell", for: indexPath) as? SpaceShipTableViewCell else {
            return UITableViewCell()
        }
        cell.configSpaceShipCell(spaceShip: self.viewModel.fetchedShips[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "LaunchDetail", bundle: nil)
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
                self.viewModel.filterShipsByMissionName()
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "By Launch Year",
            style: .default,
            handler: { _ in
                self.viewModel.filterShipsByLaunchYear()
            }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Reset",
            style: .default,
            handler: { _ in
                self.viewModel.resetFilter()
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

extension SpaceShipViewController: SpaceShipViewModelDelegate {
    
    // MARK: Delegate Methods
    func refreshData() {
        self.spaceShipTableView.reloadData()
    }

    func showAlertMessage(message: String?) {
        self.showAlert(message: message)
    }

    func showSpinner() {
        self.showLoadingHUD(view: spaceShipTableView)
    }
    
    func hideSpinner() {
        self.hideLoadingHUD(view: spaceShipTableView)
    }
}
