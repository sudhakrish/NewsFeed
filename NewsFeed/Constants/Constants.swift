//
//  Constants.swift
//  NewsFeed
//
//  Created by Ratheesh on 30/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import Foundation

let baseUrl = "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api"

let kConsumerSecretKey = "consumer-secret"
let kConsumerSecretValue = "20891a1b4504ddc33d42501f9c8d2215fbe85008"

let kConsumerKey = "consumer-key"
let kConsumerValue = "mobile_dev"

let kGetMethod = "GET"
let kPostMethod = "POST"

let kSelfMatches = "SELF MATCHES %@"
let kEmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
let kMobileNumberRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
