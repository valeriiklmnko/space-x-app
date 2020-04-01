//
//  SpaceShipError.swift
//  space-x-app
//
//  Created by Valerii Klymenko on 11/03/2020.
//  Copyright © 2020 Valerii Klymenko. All rights reserved.
//

import Foundation

enum SpaceError: Error {
    case genericError
    case pageNotFound
    case internalServerError
    case noData
    case invalidUrl

    static func getResponseError(statusCode: Int?, data: Data?) -> SpaceError? {
        guard let httpStatusCode = statusCode else {
            return .genericError
        }

        switch httpStatusCode {
        case 200:
            if data == nil {
                return .noData
            }
        case 404:
            return .pageNotFound
        case 500:
            return .internalServerError
        default:
            return .genericError
        }
        return nil
    }

    func getSpaceErrorString() -> String {
        switch self {
        case .genericError:
            return "Sorry bro"
        case .pageNotFound:
            return "404 Page Not Found"
        case .internalServerError:
            return "500 Internal Server Error"
        case .noData:
            return "Data not found"
        case .invalidUrl:
            return "Invalid URL"
        }
    }
}
