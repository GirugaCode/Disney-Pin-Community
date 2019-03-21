//
//  NewsTableViewController.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
//    var news: [News] = News.fetchVideos()
    var news = [DisneyNews]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Disney Pin News"
        
//        tableView.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)

        
        tableView.register(
            NewsTableViewCell.nib,
            forCellReuseIdentifier: NewsTableViewCell.identifier
        )
        //tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        NewsServices.shared.getNews { (result) in
            switch result {
            case let .success(articles):
                self.news = articles
                print("articles")
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        let currentNews = news[indexPath.row]
        cell.articleTitle.text = currentNews.title
//        let disneyNews = NewsList[indexPath.row]
//        let video = news[indexPath.row]
//        cell.news = video
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
