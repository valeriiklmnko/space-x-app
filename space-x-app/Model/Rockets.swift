//
//  Rocket.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 27/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

class Rockets: Codable {
    let rocketName: String
    let rocketImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
        case rocketImages = "flickr_images"
    }
}
