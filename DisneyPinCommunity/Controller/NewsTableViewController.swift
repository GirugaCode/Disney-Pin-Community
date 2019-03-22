//
//  NewsTableViewController.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news = [DisneyNews]()
    private var selectedDisneyNews: DisneyNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Disney Pin News"
        
        
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = news[indexPath.row]
        let newsDetailVc = NewsDetailsViewController.instantiate()
        newsDetailVc.selectedNews = selectedNews
        navigationController?.pushViewController(newsDetailVc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func reloadDataSource() {
        NewsServices.shared.getNews { (newsGetResult) in
            switch newsGetResult {
            case let .success(articles):
                self.news = articles
            case let .failure(error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
