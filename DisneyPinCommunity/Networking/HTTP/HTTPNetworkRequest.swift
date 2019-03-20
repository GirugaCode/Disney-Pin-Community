//
//  HTTPNetworkRequest.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/19/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

/*
 Handles the request from the API endpoint
 */

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: String]?

struct HTTPNetworkRequest {
    
    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters, and method: HTTPMethod, contains body: Data?) throws -> URLRequest {
        
        guard let url = URL(string: "\(Constants.DISNEY_PIN_NEWS_API_URL)\(route.rawValue)") else { fatalError("Error while unwrapping url")}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: nil, request: &request)
        
        return request
    }
    
    /// Configure the request parameters and headers before the API Call
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                              headers: HTTPHeaders?,
                                              request: inout URLRequest) throws {
        
        do {
            
            if let headers = headers, let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
}
