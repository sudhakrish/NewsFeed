//
//  LoginViewModel.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {

    func getApiData(completion: @escaping ((NewsModel?) -> ())) {
        
        APIService.serviceRequest(loginRequest, NewsModel.self) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
        }
        
    }

    /*
     Form News API Url
     */
    private var loginUrl : String {
        return baseUrl + "/iskan/v1/certificates/towhomitmayconcern?local=en"
    }
    
    private var requestBody : [String: Any] {
        
        return ["userId" :  "",
                "idToken" :  ""]
    }

    private var loginRequest : URLRequest {
        
        return URLRequest.postRequestWithdefaultConfiguration(loginUrl, requestJson: requestBody)!
    }

}
