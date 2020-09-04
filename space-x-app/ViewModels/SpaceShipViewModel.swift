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
    func showSpinner()
    func hideSpinner()
    func showAlertMessage(message: String?)
}

class SpaceShipViewModel {

    private let apiClient: ApiClient
    weak var delegate: SpaceShipViewModelDelegate?
    private let userDefaultsStorage = UserDefaultsStorage(defaults: UserDefaults.standard)

    init(apiClient: ApiClient, delegate: SpaceShipViewModelDelegate?) {
        self.apiClient = apiClient
        self.delegate = delegate
    }

    var fetchedShips = [SpaceShip]() {
        didSet {
            self.delegate?.refreshData()
        }
    }
    
    var storedShipsData = [SpaceShip]()
    var isInitialDataLoad = true

    func fetchShips() {
        self.delegate?.showSpinner()
        self.apiClient.fetchShips(
            completionHandler: { (result, error) in
                self.delegate?.hideSpinner()
                guard let result = result else {
                    self.delegate?.showAlertMessage(message: error?.getSpaceErrorString())
                    return
                }
                self.fetchedShips = result
                self.storedShipsData = result
                self.delegate?.refreshData()
                if self.isInitialDataLoad {
                    self.isInitialDataLoad = false
                    self.setInitialFilter()
                }
            }
        )
    }
        
    func setInitialFilter() {
        if let filter = self.userDefaultsStorage.getFilter() {
            switch filter {
            case .byMissionName:
                self.filterShipsByMissionName()
            case .byLaunchYear:
                self.filterShipsByLaunchYear()
            case .defaultState:
                self.delegate?.refreshData()
            }
        } else {
            self.delegate?.refreshData()
        }
    }
    
    // MARK: Filtering Methods
    func filterShipsByMissionName() {
        self.fetchedShips = self.fetchedShips.sorted(by: { $0.missionName < $1.missionName })
        self.userDefaultsStorage.save(filter: .byMissionName)
    }
        
    func filterShipsByLaunchYear() {
        self.fetchedShips = self.storedShipsData
        self.fetchedShips = self.fetchedShips.sorted(by: { $0.launchYear < $1.launchYear })
        self.userDefaultsStorage.save(filter: .byLaunchYear)
    }
        
    func resetFilter() {
        self.fetchedShips = self.storedShipsData
        self.userDefaultsStorage.save(filter: .defaultState)
    }
}
