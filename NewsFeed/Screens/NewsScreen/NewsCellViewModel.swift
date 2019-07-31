//
//  NewsCellViewModel.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import Foundation

class NewsCellViewModel: NSObject {
    
    var news: NewsModel.News? = nil
    
    var newsImageURLString: String? {
        
        return "\(news?.image ?? "")"
    }
    
    var titleString: String? {
        return "\(news?.title ?? "")"
    }
    
    var descriptionString: String? {
        return "\(news?.description ?? "")"
    }
    
    var dateString: String? {
        return "Updated on \(news?.date ?? "")"
    }
    
}
