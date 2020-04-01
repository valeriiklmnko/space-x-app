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
    @IBOutlet weak var cellImageView: UIImageView!
    
    func configureRocketCell(rocket: Rocket) {
        let viewModel = RocketImageViewModel(apiClient: ApiClient.shared, delegate: self)
        viewModel.fetchRocketImage(rocket: rocket)
        self.rocketName.text = rocket.rocketName
        self.rocketName.textColor = .blue
    }
}

extension RocketCollectionViewCell: RocketImageViewModelDelegate {
    func setFetchedImage(image: UIImage) {
        self.cellImageView.image = image
    }
    
    func setDefaultImage() {
        self.cellImageView.image = UIImage(named:"launch-mission")!
    }
}
