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
    
    func getNews(_ completion: @escaping (Result<[DisneyNews]>) -> ()) {
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .articles, with: nil, and: .get, contains: nil)
            postSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(NewsList.self, from: unwrappedData)
                        guard let unwrappedResult = result?.articles else { return }
                        completion(Result.success(unwrappedResult)) 
                        
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
