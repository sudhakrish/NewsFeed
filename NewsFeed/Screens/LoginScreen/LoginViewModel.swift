//
//  LoginViewModel.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {

    var body : [String: Any] = [:]
    var errorMessage: String?

    /*
     Call Login API
     */

    func getApiData(completion: @escaping ((LoginModel?) -> ())) {
        
        APIService.serviceRequest(loginRequest, LoginModel.self) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.errorMessage = error?.localizedDescription
                completion(nil)
                return
            }
            
            guard let model = data as? LoginModel else {
                weakSelf.errorMessage = "No items, please try again"
                completion(nil)
                return
            }
            
            if let success = model.success, success == false {
                weakSelf.errorMessage = model.message
                completion(nil)
                return
            }

            completion(model)
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
        return baseUrl + SuffixUrl.eLogin.url
    }
    
    private var loginRequest : URLRequest {
        
        return URLRequest.postRequestWithdefaultConfiguration(loginUrl, requestJson: body)!
    }

}
