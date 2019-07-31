//
//  NewsFeedViewModel.swift
//  NewsFeed
//
//  Created by Ratheesh on 30/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class NewsFeedViewModel: NSObject {
    
    private var newsModel: NewsModel?
    var errorMessage: String?
    
    /*
     Fetch news API to get feeds
     */

    func getApiData(completion: @escaping ((NewsModel?) -> ())) {
        
        APIService.serviceRequest(newsRequest, NewsModel.self) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.errorMessage = error?.localizedDescription
                completion(nil)
                return
            }
            
            guard let data = data as? NewsModel else {
                weakSelf.errorMessage = "No items, please try again"
                completion(nil)
                return
            }
            weakSelf.newsModel = data
            completion(data)
        }
        
    }
    
    /*
    Prepare data model object
     */

    var newsList: [NewsModel.News] {
        
        return newsModel?.newsList ?? []
    }
    
    /*
     Form News API Url
     */
    private var newsUrl: String {
        return baseUrl + "/public/v1/news?local=en"
    }
    
    private var newsRequest:URLRequest  {
        let urlRequest = URLRequest.getRequestWithdefaultConfiguration(newsUrl)
        
        return urlRequest!
    }
    
}
