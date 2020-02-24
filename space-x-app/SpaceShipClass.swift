//
//  SpaceShipClass.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class SpaceShip {
    let rocketName: String
    let launchDate: String
    let launchYear: String
    let missionName: String
    let launchSite: String
    
    init(
        rocketName: String,
        launchDate: String,
        launchYear: String,
        missionName: String,
        launchSite: String
    ) {
        self.rocketName = rocketName
        self.launchDate = launchDate
        self.launchYear = launchYear
        self.missionName = missionName
        self.launchSite = launchSite
    }
}
