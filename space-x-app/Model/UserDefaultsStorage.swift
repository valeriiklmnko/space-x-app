//
//  UserDefaultsStorage.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 19/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

enum Filter: String {
    case defaultState
    case byMissionName
    case byLaunchYear
}

class UserDefaultsStorage {
    var defaults: UserDefaults
    private let filterKey = "filterKey"
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    func save(filter: Filter) {
        self.defaults.set(filter.rawValue, forKey: self.filterKey)
    }
    
    func getFilter() -> Filter? {
        guard let stringValue = self.defaults.string(forKey: self.filterKey) else {
            return Filter.defaultState
        }
        return Filter(rawValue: stringValue) ?? Filter.defaultState
    }
}
