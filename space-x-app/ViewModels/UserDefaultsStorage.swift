//
//  UserDefaultsStorage.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 19/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

class UserDefaultsStorage {
    var defaults: UserDefaults
    let filterKey = "filterKey"
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    enum FilterValues: String {
        case defaultState
        case byMissionName
        case byLaunchYear
    }
    
    func saveFilter(value: String, key: String) {
        defaults.set(value, forKey: key)
    }
    
    func getFilter(key: String) -> String? {
        return defaults.string(forKey: key)
    }
}
