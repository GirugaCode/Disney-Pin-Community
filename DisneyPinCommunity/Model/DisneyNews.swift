//
//  DisneyNews.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct DisneyNews {
    
    let id: Int
    let title: String
    let date: String
    let description: String
    let pictureURL: String
    let pictureDescription: String
}

struct NewsList: Decodable {
    let articles : [DisneyNews]
}

extension DisneyNews: Decodable {
    
    enum NewsKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case date = "date"
        case description = "description"
        case pictureURL = "picture_url"
        case pictureDescription = "picture_description"
    }
    
    enum PictureURLKeys: String, CodingKey {
        case imageURL = "850px"
    }
    
    init(from decoder: Decoder) throws {
        let newsContainer = try decoder.container(keyedBy: NewsKeys.self)
        
        id = try newsContainer.decode(Int.self, forKey: .id)
        title = try newsContainer.decode(String.self, forKey: .title)
        date = try newsContainer.decode(String.self, forKey: .date)
        description = try newsContainer.decode(String.self, forKey: .description)
        pictureDescription = try newsContainer.decode(String.self, forKey: .pictureDescription)
        
        let newsImageContainer = try newsContainer.nestedContainer(keyedBy: PictureURLKeys.self, forKey: .pictureURL)
        pictureURL = try newsImageContainer.decode(String.self, forKey: .imageURL)
    }
}
