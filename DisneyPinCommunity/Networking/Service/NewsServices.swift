//
//  NewsServices.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/19/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

/*
 Uses URLSessions to fetch the news from the API
 */

import Foundation

struct NewsServices {
    
    static let shared = NewsServices()
    
    
    let postSession = URLSession(configuration: .default)
    
    func getNews(_ completion: @escaping (Result<[String: [DisneyNews]]>) -> ()) {
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .articles, with: nil, and: .get, contains: nil)
            postSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode([String: [DisneyNews]].self, from: unwrappedData)
                        // FIX THIS: Fatal error found while trying to unwrap result. I am getting Data but it maybe my model thats no structured correctly
                        completion(Result.success(result!))
                        
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
                }.resume()
        }catch{
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
}
