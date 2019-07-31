//
//  LoginModel.swift
//  NewsFeed
//
//  Created by Ratheesh on 31/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

struct LoginModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case message, success
        case response = "payload"
    }
    
    let message : String?
    let success : Bool?
    let response : Response?
    
    struct Response: Codable {
        
        enum CodingKeys: String, CodingKey {
            
            case referenceNo
        }
        let referenceNo : Int?
        
    }
}
