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
        missionTitle.text = "Mission:"
        missionTitle.lineBreakMode = .byClipping
        yearTitle.text = "Year:"
        yearTitle.lineBreakMode = .byClipping
        missionLabel.text = spaceShip.missionName
        missionLabel.lineBreakMode = .byClipping
        yearLabel.text = spaceShip.launchYear
        yearLabel.lineBreakMode = .byClipping
        cellImageView.image = UIImage(named: "rocket-logo")
    }
}
