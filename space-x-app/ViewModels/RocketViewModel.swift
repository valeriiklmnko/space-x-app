//
//  RocketsViewModel.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 27/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

protocol RocketViewModelDelegate: AnyObject {
    func refreshData()
    func showSpinner()
    func hideSpinner()
    func showAlertMessage(message: String?)
}

class RocketViewModel {
    
    private let apiClient: ApiClient
    weak var delegate: RocketViewModelDelegate?
    
    init(apiClient: ApiClient, delegate: RocketViewModelDelegate?) {
        self.apiClient = apiClient
        self.delegate = delegate
    }
    
    var fetchedRockets = [Rocket]() {
        didSet {
            self.delegate?.refreshData()
        }
    }

    func fetchRockets() {
        self.delegate?.showSpinner()
        self.apiClient.fetchRockets(
            completionHandler: { (result, error) in
                self.delegate?.hideSpinner()
                guard let result = result else {
                    self.delegate?.showAlertMessage(message: error?.getSpaceErrorString())
                    return
                }
                self.fetchedRockets = result
                self.delegate?.refreshData()
            }
        )
    }
}
