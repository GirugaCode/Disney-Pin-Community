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
    lazy var refreshController = UIRefreshControl()
    private var selectedDisneyNews: DisneyNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        reloadDataSource()
        refreshTableView()
        
        tableView.register(
            NewsTableViewCell.nib,
            forCellReuseIdentifier: NewsTableViewCell.identifier
        )
        
        let headerNib = UINib.init(nibName: "DisneyHeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "DisneyHeaderView")
    }
    
    private func navigationUI() {
        self.title = "Disney Pin Community"
        self.tableView.separatorStyle = .none
    }
    
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DisneyHeaderView") as! DisneyHeaderView

        headerView.headerLabel.text = "Disney Pin News"

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
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
    
    private func refreshTableView() {
        
        refreshController.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshController.tintColor = .red
        refreshController.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshController) // not required when using UITableViewController
        
    }
    
    @objc func refresh() {
        // Code to refresh table view
        tableView.reloadData()
        refreshController.endRefreshing()
    }
}
