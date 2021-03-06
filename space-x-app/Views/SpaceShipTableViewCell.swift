//
//  SpaceShipTableViewCell.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class SpaceShipTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var missionTitle: UILabel!
    @IBOutlet weak var yearTitle: UILabel!
    
    func configSpaceShipCell(spaceShip: SpaceShip) {
        self.missionTitle.text = "Mission:"
        self.missionLabel.text = spaceShip.missionName
        self.yearTitle.text = "Year:"
        self.yearLabel.text = spaceShip.launchYear
    }
}
