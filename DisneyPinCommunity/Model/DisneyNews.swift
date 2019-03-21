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
    let date: String?
    let description: String?
    let picture: String?
    let pictureDescription: String?
}

struct NewsList: Decodable {
    let articles : [DisneyNews]
}
