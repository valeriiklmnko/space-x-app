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
    
    let url = "https://api.spacexdata.com/v3/launches"
    
    func fetchShips(completionHandler: @escaping ([SpaceShip]?, Error?) -> ()) {
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [SpaceShip].self) { (response) in
                switch response.result {
                case .success:
                    guard let fetchedShips = response.value else { return }
                    completionHandler(fetchedShips, nil)
                    print("Successful request")
                case .failure:
                    guard let responseError = response.error else { return }
                    completionHandler(nil, responseError)
                    print("Request failed \(responseError.localizedDescription)")
                }
        }
    }
    
    enum SpaceError: String {
        case genericError = "sorry bro, something is broken"
    }
    
    enum DefaultError: Error {
        case defaultError
    }
    
    func mapErrorFrom(error: Error ) -> SpaceError {
        switch error {
        default:
            return SpaceError.genericError
        }
     }
    
    private init() {}
}
