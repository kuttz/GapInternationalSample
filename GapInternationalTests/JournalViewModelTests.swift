//
//  JournalViewModelTests.swift
//  GapInternationalTests
//
//  Created by Sreekuttan D on 23/07/23.
//

import XCTest
@testable import GapInternational

final class JournalViewModelTests: XCTestCase {
    
    let user: User = User(userName: "TestUser", password: "TestUser@123")
    
    func testInitWithUser() {
        
        let sut: JournalViewModel = JournalViewModel(user: user, webservice: DummyJournalWebService())
    
        XCTAssertNotNil(sut.user)
        
        XCTAssertEqual(sut.user.userName, "TestUser")
        
    }
    
    func testGetAllJournalsSuccess() {
        
        let expectation = self.expectation(description: "GetAllJournalsSuccess")
        let mockDelegate = MockJournalViewDelegate(expectation: expectation)
        let sut: JournalViewModel = JournalViewModel(user: user, webservice: DummyJournalWebService())
        sut.journalDelegate = mockDelegate
        
        sut.getAllJournals()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(!sut.journals.isEmpty)
                
        XCTAssertNil(mockDelegate.message)
        
    }
    
}
