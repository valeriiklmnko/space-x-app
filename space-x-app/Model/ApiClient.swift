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
                    completionHandler(
                        response.value,
                        SpaceError.getResponseError(statusCode: statusCode, data: response.data)
                    )
                case .failure:
                    completionHandler(
                        nil,
                        SpaceError.getResponseError(statusCode: statusCode, data: response.data)
                    )
                }
            }
    }
    
    func fetchRockets(completionHandler: @escaping ([Rocket]?, SpaceError?) -> ()) {
        guard let url = rocketsURL else {
            completionHandler(nil, SpaceError.invalidUrl)
            return
        }
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [Rocket].self) { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    completionHandler(
                        response.value,
                        SpaceError.getResponseError(statusCode: statusCode, data: response.data)
                    )
                case .failure:
                    completionHandler(
                        nil,
                        SpaceError.getResponseError(statusCode: statusCode, data: response.data)
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
                completionHandler(
                    response.value,
                    SpaceError.getResponseError(statusCode: statusCode, data: response.data)
                )
            case .failure:
                completionHandler(
                    nil,
                    SpaceError.getResponseError(statusCode: statusCode, data: response.data)
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
