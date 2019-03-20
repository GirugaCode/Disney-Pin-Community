//
//  HTTPMethod.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/19/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

/*
 Handles the request method from the API endpoint
 */

import Foundation

public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
}
