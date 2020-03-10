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
        AF.request(launchesURL ?? "https://api.spacexdata.com", method: .get)
            .validate()
            .responseDecodable(of: [SpaceShip].self, decoder: decoder) { (response) in
                switch response.result {
                case .success:
                    completionHandler(response.value, nil)
                    print("Successful request")
                case .failure:
                    completionHandler(nil, SpaceError.genericError)
                    print("Request failed \(SpaceError.genericError)")
                }
        }
    }
    
    // MARK: Error mapping
    enum SpaceError: Error {
        case genericError
        
        func getError() -> String {
            switch self {
            case .genericError:
                return "Sorry bro"
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
