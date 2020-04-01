//
//  RocketsViewController.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 26/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class RocketsViewController: CommonViewController {
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables and Constants
    lazy private(set) var viewModel = RocketViewModel(apiClient: ApiClient.shared, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.viewModel.fetchRockets()
    }
    
    // MARK: Actions
    @IBAction func showModal(_ sender: Any) {
        let modalStoryboard = UIStoryboard(name: "Modal", bundle: nil)
        if let modalVC = modalStoryboard.instantiateViewController(identifier: "Modal") as? ModalViewController {
            let navController = UINavigationController(rootViewController: modalVC)
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }
}

extension RocketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: CollectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.fetchedRockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as? RocketCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureRocketCell(rocket: self.viewModel.fetchedRockets[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rocketDetailStoryboard = UIStoryboard(name: "RocketDetail", bundle: nil)
        if let detailViewController = rocketDetailStoryboard.instantiateViewController(identifier: "RocketDetailViewController") as? RocketDetailViewController {
            detailViewController.selectedRocket = self.viewModel.fetchedRockets[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension RocketsViewController: RocketViewModelDelegate {
    
    // MARK: Delegate Methods
    func refreshData() {
        self.collectionView.reloadData()
    }
    
    func showAlertMessage(message: String?) {
        self.showAlert(message: message)
    }
    
    // MARK: Spinner Methods
    func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: collectionView, animated: true)
        hud.label.text = "Loading..."
    }

    func hideLoadingHUD() {
        MBProgressHUD.hide(for: collectionView, animated: true)
    }
}
