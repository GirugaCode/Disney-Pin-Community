//
//  NewsDetailsViewController.swift
//  DisneyPinCommunity
//
//  Created by Ryan Nguyen on 3/21/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    
    let dateFormatterGet = Date()
    var selectedNews: DisneyNews?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(addTapped))

    }
    
    @objc func addTapped() {
        print("Tapped Button!")
        let activityController = UIActivityViewController(activityItems: [articleTitle.text as Any, articleImage.image as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    private func updateUI() {
        guard let date = selectedNews?.date else { return }
        let strippedDate  = String(date.prefix(10))
        
        let cleanedDate = dateFormatterGet.getFormattedDate(dateString: strippedDate, formatter: "MMM dd,yyyy")
        
        articleTitle.text = selectedNews?.title
        articleDate.text = String(describing: cleanedDate)
        articleDescription.text = selectedNews?.description
        articleDescription.adjustsFontSizeToFitWidth = true
        
        loadImages()
    }
    
    private func loadImages() {
    
        if let imageUrl = selectedNews?.picture {
            guard let url = URL(string: imageUrl) else { return }
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil {
                    let loadedImage = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.articleImage.image = loadedImage
                    }
                    
                }
            }
            task.resume()
        } else {
            articleImage.image = #imageLiteral(resourceName: "v2")
        }
    }
}
