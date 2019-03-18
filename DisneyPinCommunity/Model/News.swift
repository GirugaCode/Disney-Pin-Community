//
//  News.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct News {

    let authorName: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String
    
    static func fetchVideos() -> [News] {
        let v1 = News(authorName: "Ryan Nguyen", videoFileName: "v1", description: "This is an example of local video.", thumbnailFileName: "v1")
        let v2 = News(authorName: "John Doe", videoFileName: "v2", description: "This is an example of local video.", thumbnailFileName: "v2")
        let v3 = News(authorName: "Timmy Tom", videoFileName: "v3", description: "This is an example of local video.", thumbnailFileName: "v3")
        let v4 = News(authorName: "Yeetus", videoFileName: "v4", description: "This is an example of local video.", thumbnailFileName: "v4")
        let v5 = News(authorName: "Created Article", videoFileName: "v5", description: "This is an example of local video.", thumbnailFileName: "v5")
        let v6 = News(authorName: "Steve Jobs", videoFileName: "v6", description: "This is an example of local video.", thumbnailFileName: "v6")
        
        return [v1, v2, v3, v4, v5, v6]
    }
}
