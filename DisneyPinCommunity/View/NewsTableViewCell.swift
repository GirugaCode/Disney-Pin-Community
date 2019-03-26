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
    @IBOutlet weak var containerView: UIView! {
        didSet {
            previewNewsUI()
        }
    }
    @IBOutlet weak var articleThumbnail: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    
    let dateFormatterGet = Date()
    let imageCache = NSCache<AnyObject, AnyObject>()

    static let identifier = "NewsTableViewCell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    var sourceItem: DisneyNews! {
        didSet {
            updateUI()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleThumbnail.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    private func updateUI() {
        guard let sourceItem = sourceItem else { return }
        guard let date = sourceItem.date else { return }
        let strippedDate  = String(date.prefix(10))

        let cleanedDate = dateFormatterGet.getFormattedDate(dateString: strippedDate, formatter: "MMM dd,yyyy")
        
        articleTitle.text = sourceItem.title
        articleTitle.adjustsFontSizeToFitWidth = true
        articleDate.text = String(describing: cleanedDate)
        articleThumbnail.layer.cornerRadius = 8.0
        articleThumbnail.layer.masksToBounds = true
        
        loadImages()
    }
    
    private func previewNewsUI() {
        containerView.layer.cornerRadius = 18
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        containerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.layer.borderColor = #colorLiteral(red: 0.974335134, green: 0.5811371803, blue: 0.02610809356, alpha: 1)
        containerView.layer.borderWidth = 1.4

    }
    
    private func loadImages() {
        if let imageUrl = sourceItem.picture {
            guard let url = URL(string: imageUrl) else { return }
            let request = URLRequest(url: url)
            
            if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) {
                self.articleThumbnail.image = imageFromCache as? UIImage
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil {
                    let loadedImage = UIImage(data: data!)
                    DispatchQueue.main.async {
                        let imageToCache = loadedImage
                        self.imageCache.setObject(imageToCache!, forKey: imageUrl as AnyObject)
                        self.articleThumbnail.image = imageToCache
                    }
                    
                }
            }
            task.resume()
        } else {
            articleThumbnail.image = #imageLiteral(resourceName: "Disney Pin Community logo")
        }
    }
}

