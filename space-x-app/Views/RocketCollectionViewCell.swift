//
//  RocketCollectionViewCell.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 27/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class RocketCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    lazy private(set) var viewModel = RocketsImageViewModel(apiClient: ApiClient.shared, collectionViewCell: self)

    func configureRocketCell(rockets: Rockets) {
        self.viewModel.fetchRocketImage(rockets: rockets)
        self.rocketName.text = rockets.rocketName
        self.rocketName.textColor = .blue
    }
}
