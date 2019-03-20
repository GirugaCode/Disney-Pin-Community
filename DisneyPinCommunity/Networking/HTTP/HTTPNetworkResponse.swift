//
//  HTTPNetworkRequest.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/19/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

/*
 Handles the HTTP Response code for the API
 */

import Foundation

struct HTTPNetworkResponse {

    // Properly checks and handles the status code of the response
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String>{

        guard let res = response else { return Result.failure(HTTPNetworkError.UnwrappingError)}

        switch res.statusCode {
        case 200...299: return .success(HTTPNetworkError.success.rawValue)
        case 401: return .failure(HTTPNetworkError.authenticationError)
        case 400...499: return .failure(HTTPNetworkError.badRequest)
        case 500...599: return .failure(HTTPNetworkError.serverSideError)
        default: return .failure(HTTPNetworkError.failed)
        }
    }

}
