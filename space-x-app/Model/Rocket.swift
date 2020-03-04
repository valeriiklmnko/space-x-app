//
//  Rocket.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 28/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class Rocket: Decodable {
    let rocketName: String
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
    }
}
