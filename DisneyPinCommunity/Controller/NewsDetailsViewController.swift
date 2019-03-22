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
    
    var selectedNews: DisneyNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        articleTitle.text = selectedNews?.title
        articleDate.text = selectedNews?.date
        articleDescription.text = selectedNews?.description
        articleDescription.adjustsFontSizeToFitWidth = true
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
