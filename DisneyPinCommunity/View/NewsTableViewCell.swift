//
//  NewsTableViewCell.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

/*
 Custom Cell for Disney Pin News
 */

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var articleThumbnail: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    
    static let identifier = "NewsTableViewCell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var sourceItem: DisneyNews! {
        didSet {
            updateUI()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        guard let sourceItem = sourceItem else { return }
        articleTitle.text = sourceItem.title
        articleThumbnail.layer.cornerRadius = 8.0
        articleThumbnail.layer.masksToBounds = true
        
    }
    
}
