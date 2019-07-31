//
//  NewsTableCell.swift
//  NewsFeed
//
//  Created by Ratheesh on 30/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var cellViewModel: NewsCellViewModel? = nil
    
    func configureCell() {
        
        title.text = cellViewModel?.titleString
        time.text = cellViewModel?.dateString
        
        // Load images with activity spinner
        activity.startAnimating()
        photo.image = UIImage()
        photo.loadImage(cellViewModel?.newsImageURLString) { [weak self] (loaded) in
            
            guard let weakSelf = self else {  return }
            
            if loaded {
                weakSelf.activity.stopAnimating()
            }
        }
    }
}
