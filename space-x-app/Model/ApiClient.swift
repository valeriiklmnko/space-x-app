//
//  ApiClient.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 03/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ApiClient {
    static let shared = ApiClient()
    let launchesURL = URL(string: "https://api.spacexdata.com/v3/launches")
    let rocketsURL = URL(string: "https://api.spacexdata.com/v3/rockets")
    let decoder = JSONDecoder()
    
    private init() {}
    
    func fetchShips(completionHandler: @escaping ([SpaceShip]?, SpaceError?) -> ()) {
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Custom)
        guard let url = launchesURL else {
            completionHandler(nil, SpaceError.invalidUrl)
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [SpaceShip].self, decoder: decoder) { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    if let error = SpaceError.getSpaceError(statusCode: statusCode, data: response.value) {
                        completionHandler(nil, error)
                    } else {
                        completionHandler(response.value, nil)
                    }
                case .failure:
                    completionHandler(
                        nil,
                        SpaceError.getSpaceError(
                            statusCode: statusCode,
                            data: response.value
                        )
                    )
                }
        }
    }
    
    func fetchRockets(completionHandler: @escaping ([Rockets]?, SpaceError?) -> ()) {
        guard let url = rocketsURL else {
            completionHandler(nil, SpaceError.invalidUrl)
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [Rockets].self) { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    if let error = SpaceError.getRocketsError(statusCode: statusCode, data: response.value) {
                        completionHandler(nil, error)
                    } else {
                        completionHandler(response.value, nil)
                    }
                case .failure:
                    completionHandler(
                        nil,
                        SpaceError.getRocketsError(statusCode: statusCode, data: response.value)
                    )
                }
        }
    }
    
    func fetchRocketImage(url: String?, completionHandler: @escaping (UIImage?, SpaceError?) -> ()) {
        guard let url = url else {
            completionHandler(nil, SpaceError.invalidUrl)
            return
        }
        AF.request(url).responseImage { response in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success:
                if let error = SpaceError.getRocketsImageError(statusCode: statusCode, data: response.value) {
                    completionHandler(nil, error)
                } else {
                    completionHandler(response.value, nil)
                }
            case .failure:
                completionHandler(
                    nil,
                    SpaceError.getRocketsImageError(statusCode: statusCode, data: response.value)
                )
            }
        }
    }
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
