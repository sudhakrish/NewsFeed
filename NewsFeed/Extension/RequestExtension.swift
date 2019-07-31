//
//  RequestExtension.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import Foundation

extension URLRequest {
    
    // Configure GET request with headers
    
    static func getRequestWithdefaultConfiguration(_ urlString: String?) -> URLRequest? {
        guard var urlRequest = urlRequestWithDefaultConfig(urlString) else {
            return nil
        }
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("20891a1b4504ddc33d42501f9c8d2215fbe85008", forHTTPHeaderField: "consumer-secret")
        urlRequest.addValue("mobile_dev", forHTTPHeaderField: "consumer-key")
        
        return urlRequest
    }
    
    // Configure POST request with headers

    static func postRequestWithdefaultConfiguration(_ urlString: String?, requestJson: [String : Any]?) -> URLRequest? {
        guard var urlRequest = urlRequestWithDefaultConfig(urlString) else {
            return nil
        }
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let requestBody = requestJson {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            } catch {
                debugPrint("Unexpected error: \(error).")
            }
        }
        
        return urlRequest
    }
    
    // Form URLRequest
    
    private static func urlRequestWithDefaultConfig(_ urlString: String?) -> URLRequest? {
        guard let givenURLString = urlString, let urlComponent = URLComponents.init(string: givenURLString), let url = urlComponent.url else {
            return nil
        }
        
        return URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    }
    
}
