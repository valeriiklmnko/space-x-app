//
//  ApiClient.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 03/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    static let shared = ApiClient()
    let launchesURL = URL(string: "https://api.spacexdata.com/v3/launches")
    let decoder = JSONDecoder()
    
    func fetchShips(completionHandler: @escaping ([SpaceShip]?, SpaceError?) -> ()) {
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Custom)
        guard let url = launchesURL else {
            completionHandler(nil, SpaceError.invalidUrl)
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [SpaceShip].self, decoder: decoder) { (response) in
                var error: SpaceError?
                var data: [SpaceShip]?
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    completionHandler(response.value, nil)
                    print("Successful request with \(String(describing: statusCode)) status code")
                case .failure:
                    data = response.value
                    error = SpaceError.getSpaceError(statusCode: statusCode, data: data)
                    completionHandler(nil, error)
                    print("Request failed with \(String(describing: statusCode)) status code")
                }
        }
    }
    
    private init() {}
}

extension DateFormatter {
  static let iso8601Custom: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(identifier: "UTC")
    return formatter
  }()
}
