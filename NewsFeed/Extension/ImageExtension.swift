//
//  ImageExtension.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /*
        Asynchronously load images
     */
    
    func loadImage(_ url: String?, completion: @escaping ((Bool) -> ())) {
        
        guard let urlString = url, let imageUrl = URL(string: urlString) else {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            
            guard let weakSelf = self, error == nil, let imageData = data else {
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                weakSelf.image = UIImage(data: imageData)
                completion(true)
            }
            }.resume()
    }
}
