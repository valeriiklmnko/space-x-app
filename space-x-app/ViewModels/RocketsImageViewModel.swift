//
//  RocketsImageViewModel.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 30/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class RocketsImageViewModel {
    
    private let apiClient: ApiClient
    private let collectionViewCell: RocketCollectionViewCell

    init(apiClient: ApiClient, collectionViewCell: RocketCollectionViewCell) {
        self.apiClient = apiClient
        self.collectionViewCell = collectionViewCell
    }
    
    func fetchRocketImage(rockets: Rockets) {
        self.apiClient.fetchRocketImage(
            url: rockets.rocketImages.first,
            completionHandler: { (result, error) in
                guard let result = result else {
                    self.collectionViewCell.cellImage.image = UIImage(named:"launch-mission")!
                    return
                }
                self.collectionViewCell.cellImage.image = result
            }
        )
    }
}
