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
//    var news: [DisneyNews] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Disney Pin News"
        
//        reloadDataSource()
        
        tableView.register(
            NewsTableViewCell.nib,
            forCellReuseIdentifier: NewsTableViewCell.identifier
        )

        
        reloadDataSource()
    

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.sourceItem = news[indexPath.row]
//        let disneyNews = NewsList[indexPath.row]
//        let video = news[indexPath.row]
//        cell.news = video
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func reloadDataSource() {
        NewsServices.shared.getNews { (newsGetResult) in
            switch newsGetResult {
            case let .success(articles):
                self.news = articles
                print("articles")
                print(self.news)
            case let .failure(error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
