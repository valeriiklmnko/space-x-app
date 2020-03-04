//
//  SpaceShipClass.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class SpaceShip: Decodable {
    let rocket: Rocket
    let launchDate: String
    let launchYear: String
    let missionName: String
    let launchSite: Site
    
    enum CodingKeys: String, CodingKey {
        case rocket = "rocket"
        case launchDate = "launch_date_utc"
        case launchYear = "launch_year"
        case missionName = "mission_name"
        case launchSite = "launch_site"
    }
}
