//
//  LoginTests.swift
//  NewsFeedTests
//
//  Created by Ratheesh on 01/08/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {

    private let viewModel = LoginViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidName() {
        
        XCTAssertTrue(viewModel.isValid("Ratheesh"), "Valid name")
        XCTAssertTrue(viewModel.isValid("David"), "Valid name")
        XCTAssertTrue(viewModel.isValid("David Amir"), "Valid name")

    }
    
    func testInvalidName() {
        
        XCTAssertFalse(viewModel.isValid(""), "Invalid name")
    }
    
    func testValidEmailIds() {
        
        XCTAssertTrue(viewModel.isValidEmail("ratheesh@gamil.com"), "Valid email address")
        XCTAssertTrue(viewModel.isValidEmail("yano@gamil.com"), "Valid email address")
        XCTAssertTrue(viewModel.isValid("yano@gamil.com"), "Valid email address")

    }
    
    func testInvalidEmailIds() {
        
        XCTAssertFalse(viewModel.isValidEmail("ratheesh@gamil.c"), "Invalid email address")
        XCTAssertFalse(viewModel.isValidEmail("yano.com"), "Invalid email address")
        XCTAssertFalse(viewModel.isValidEmail("yano"), "Invalid email address")
        XCTAssertFalse(viewModel.isValidEmail("yanogmail.com"), "Invalid email address")
        XCTAssertFalse(viewModel.isValid(""), "Invalid email address")

    }
    
    func testValidMobileNumbers() {
        
        XCTAssertTrue(viewModel.isValidMobile("971556987009"), "Valid mobile number")
        XCTAssertTrue(viewModel.isValidMobile("97155687009"), "Valid mobile number")
        XCTAssertTrue(viewModel.isValidMobile("941556987009"), "Valid mobile number")
        XCTAssertTrue(viewModel.isValidMobile("941556987089"), "Valid mobile number")
        XCTAssertTrue(viewModel.isValid("941556987009"), "Valid mobile number")

    }
    
    func testInValidMobileNumbers() {
        
        XCTAssertFalse(viewModel.isValidMobile("232"), "Invalid mobile number")
        XCTAssertFalse(viewModel.isValidMobile("45"), "Invalid mobile number")
        XCTAssertFalse(viewModel.isValidMobile("2"), "Invalid mobile number")
        XCTAssertFalse(viewModel.isValidMobile("%%^ssdsd"), "Invalid mobile number")
        XCTAssertFalse(viewModel.isValidMobile("++9u377r99434"), "Invalid mobile number")
        XCTAssertFalse(viewModel.isValidMobile("++9887676555"), "Invalid mobile number")
        XCTAssertFalse(viewModel.isValid(""), "Invalid mobile number")

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
