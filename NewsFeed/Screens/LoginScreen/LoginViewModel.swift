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
     Validate Input Fields
     */

    let isValid:(String) -> (Bool) = { name in
        
        return !name.isEmpty
    }
    
    let isValidEmail: (String) -> Bool = { email in
        
        guard !email.isEmpty else { return false}
        
        return NSPredicate(format: kSelfMatches, kEmailRegex).evaluate(with: email)
    }
    
    let isValidMobile: (String) -> Bool = { mobile in
        
        guard !mobile.isEmpty else { return false}
        
        return NSPredicate(format: kSelfMatches, kMobileNumberRegex).evaluate(with: mobile)
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
