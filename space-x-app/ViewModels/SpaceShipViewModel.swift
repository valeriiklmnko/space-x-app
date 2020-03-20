//
//  SpaceShipViewModel.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 19/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

protocol SpaceShipViewModelDelegate: AnyObject {
    func refreshData()
    func showLoadingHUD()
    func hideLoadingHUD()
    func showAlert(message: String?)
}

class SpaceShipViewModel {

    private let apiClient: ApiClient
    weak var delegate: SpaceShipViewModelDelegate?

    init(apiClient: ApiClient, delegate: SpaceShipViewModelDelegate?) {
        self.apiClient = apiClient
        self.delegate = delegate
    }

    
    var fetchedShips = [SpaceShip]()
//    var fetchedShips = [SpaceShip]() {
//        didSet {
//            self.delegate?.refreshData()
//        }
//    }
    
    var storedShipsData = [SpaceShip]()

    func fetchShips() {
        self.delegate?.showLoadingHUD()
        apiClient.fetchShips(
            completionHandler: { (result, error) in
                self.delegate?.hideLoadingHUD()
                guard let result = result else {
                    self.delegate?.showAlert(message: error?.getSpaceErrorString())
                    return
                }
                self.fetchedShips = result
                self.storedShipsData = self.fetchedShips
                self.delegate?.refreshData()
            }
        )
    }
}
