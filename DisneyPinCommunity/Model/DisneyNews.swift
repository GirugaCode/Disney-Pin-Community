//
//  DisneyNews.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct DisneyNews: Decodable {
    
    let title: String?
    let date: Date?
    let description: String?
    let picture: String?
    let pictureDescription: String?
    let comments: String?
}

struct NewsList: Decodable {
    let articles : [DisneyNews]
}

//extension DisneyNews {
//
//    enum NewsKeys: String, CodingKey {
//        case id
//        case title
//        case date
//        case description
//        case picture
//        case pictureDescription
//        case __v
//    }
//
//    enum PictureURLKeys: String, CodingKey {
//        case imageURL = "850px"
//    }
//
//    init(from decoder: Decoder) throws {
//        let newsContainer = try decoder.container(keyedBy: NewsKeys.self)
//
//        id = try newsContainer.decode(Int.self, forKey: .id)
//        title = try newsContainer.decode(String.self, forKey: .title)
//        date = try newsContainer.decode(String.self, forKey: .date)
//        description = try newsContainer.decode(String.self, forKey: .description)
//        pictureDescription = try newsContainer.decode(String.self, forKey: .pictureDescription)
//
//        let newsImageContainer = try newsContainer.nestedContainer(keyedBy: PictureURLKeys.self, forKey: .pictureURL)
//        pictureURL = try newsImageContainer.decode(String.self, forKey: .imageURL)
//    }
//}
