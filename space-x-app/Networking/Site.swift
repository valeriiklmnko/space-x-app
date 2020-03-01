//
//  Site.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 28/02/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import UIKit

class Site: Decodable {
    let siteName: String
    
    enum CodingKeys: String, CodingKey {
        case siteName = "site_name_long"
    }
}
