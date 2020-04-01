//
//  SpaceShipClass.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 24/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

class SpaceShip: Codable {
    let rocket: SpaceShipRocket
    let launchDate: Date
    let launchYear: String
    let missionName: String
    let launchSite: Site
    
    enum CodingKeys: String, CodingKey {
        case rocket
        case launchDate = "launch_date_utc"
        case launchYear = "launch_year"
        case missionName = "mission_name"
        case launchSite = "launch_site"
    }
}

class SpaceShipRocket: Codable {
    let rocketName: String
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
    }
}

class Site: Codable {
    let siteName: String
    
    enum CodingKeys: String, CodingKey {
        case siteName = "site_name_long"
    }
}
