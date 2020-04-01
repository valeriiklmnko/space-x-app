//
//  RocketsImageViewModel.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 30/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

protocol RocketImageViewModelDelegate: AnyObject {
    func setFetchedImage(image: UIImage)
    func setDefaultImage()
}

class RocketImageViewModel {
    
    private let apiClient: ApiClient
    weak var delegate: RocketImageViewModelDelegate?

    init(apiClient: ApiClient, delegate: RocketImageViewModelDelegate?) {
        self.apiClient = apiClient
        self.delegate = delegate
    }
    
    func fetchRocketImage(rocket: Rocket) {
        self.apiClient.fetchRocketImage(
            url: rocket.rocketImages.first,
            completionHandler: { (result, error) in
                guard let result = result else {
                    self.delegate?.setDefaultImage()
                    return
                }
                self.delegate?.setFetchedImage(image: result)
            }
        )
    }
}
