//
//  UserViewModelTests.swift
//  GapInternationalTests
//
//  Created by Sreekuttan D on 23/07/23.
//

import XCTest
@testable import GapInternational

final class UserViewModelTests: XCTestCase {
    
    
    func testRegisterUserSuccess() {
        
        let expectation = self.expectation(description: "RegisterUserSuccess")
        let mockDelegate = MockUserRegistrationDelegate(expectation: expectation)
        let sut: UserViewModel = UserViewModel(webservice: DummyUserWebService()) { _, _ in
            
        }
        sut.registerDelegate = mockDelegate
        sut.registerUser(with: "TestUser", andPassword: "TestUser@123")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(sut.user)
        
        XCTAssertEqual(sut.user?.userName, "TestUser")
        
        XCTAssertEqual(sut.user?.password, "TestUser@123")
        
        XCTAssertNil(mockDelegate.message)
    }
    
    func testRegisterUserFail() {
        
        let expectation = self.expectation(description: "RegisterUserFail")
        let mockDelegate = MockUserRegistrationDelegate(expectation: expectation)
        let sut: UserViewModel = UserViewModel(webservice: DummyUserWebService()) { _, _ in
            
        }
        sut.registerDelegate = mockDelegate
        sut.registerUser(with: "", andPassword: "")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(sut.user)
        
        XCTAssertEqual(mockDelegate.message, "User name or Pasword can't be empty")
        
    }
    
    func testLoginUserSuccess() {
        
        let expectation = self.expectation(description: "LoginUserSuccess")
        let mockDelegate = MockUserLoginDelegate(expectation: expectation)
        let sut: UserViewModel = UserViewModel(webservice: DummyUserWebService()) { _, _ in
            
        }
        sut.loginDelegate = mockDelegate
        sut.userLogin(name: "TestUser", password: "TestUser@123")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(sut.user)
        
        XCTAssertEqual(sut.user?.userName, "TestUser")
        
        XCTAssertEqual(sut.user?.password, "TestUser@123")
        
        XCTAssertNil(mockDelegate.message)
    }
    
    func testLoginUserFail() {
        
        let expectation = self.expectation(description: "LoginUserFail")
        let mockDelegate = MockUserLoginDelegate(expectation: expectation)
        let sut: UserViewModel = UserViewModel(webservice: DummyUserWebService()) { _, _ in
            
        }
        sut.loginDelegate = mockDelegate
        sut.userLogin(name: "", password: "")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(sut.user)
        
        XCTAssertEqual(mockDelegate.message, "User name or Password can't be empty")
                
    }
    
}

