//
//  URLEncoder.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/19/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

public struct URLEncoder {
    
    /// Encode and set the parameters of a url request
    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        guard let url = urlRequest.url, let params = parameters else { throw HTTPNetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !params.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
    }
    
    /// Set the addition http headers of the request
    static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {
        guard let unwrapped = headers else { throw HTTPNetworkError.headersNil }
        
        for (key, value) in unwrapped{
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
