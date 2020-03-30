//
//  RocketsViewModel.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 27/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

protocol RocketsViewModelDelegate: AnyObject {
    func refreshData()
    func showLoadingHUD()
    func hideLoadingHUD()
    func showAlert(message: String?)
}

class RocketsViewModel {
    
    private let apiClient: ApiClient
    weak var delegate: RocketsViewModelDelegate?
    
    init(apiClient: ApiClient, delegate: RocketsViewModelDelegate?) {
        self.apiClient = apiClient
        self.delegate = delegate
    }
    
    var fetchedRockets = [Rockets]() {
        didSet {
            self.delegate?.refreshData()
        }
    }

    func fetchRockets() {
        self.delegate?.showLoadingHUD()
        self.apiClient.fetchRockets(
            completionHandler: { (result, error) in
                self.delegate?.hideLoadingHUD()
                guard let result = result else {
                    self.delegate?.showAlert(message: error?.getSpaceErrorString())
                    return
                }
                self.fetchedRockets = result
                self.delegate?.refreshData()
            }
        )
    }
}
