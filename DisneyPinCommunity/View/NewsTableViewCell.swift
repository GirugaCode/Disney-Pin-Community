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
    @IBOutlet weak var articleDate: UILabel!
    
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
        articleDate.text = sourceItem.date
        articleThumbnail.layer.cornerRadius = 8.0
        articleThumbnail.layer.masksToBounds = true
        
        
        if let imageUrl = sourceItem.picture {
            guard let url = URL(string: imageUrl) else { return }
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil {
                    let loadedImage = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.articleThumbnail.image = loadedImage
                    }
                    
                }
            }
            task.resume()
        } else {
            articleThumbnail.image = #imageLiteral(resourceName: "v2")
        }
        
    }
    
}
