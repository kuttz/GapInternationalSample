//
//  ExpectationDelegateClass.swift
//  GapInternationalTests
//
//  Created by Sreekuttan D on 23/07/23.
//

import Foundation
import XCTest
@testable import GapInternational

class ExpectationDelegateClass: NSObject {
    
    var expectation: XCTestExpectation
    
    var message: String?
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
        super.init()
    }
}

class MockUserRegistrationDelegate: ExpectationDelegateClass, UserViewRegistrationDelegate {
    
    func onRegistrationSuccess() {
        expectation.fulfill()
    }
    
    func onRegistrationFailed(message: String) {
        
        self.message = message
        
        expectation.fulfill()
    }
    
}

class MockUserLoginDelegate: ExpectationDelegateClass, UserViewLoginDelegate {
        
    
    func onLoginSuccess(with user: User) {
        expectation.fulfill()
    }
    
    func onLoginFailed(message: String) {
        
        self.message = message
        
        expectation.fulfill()
    }
    
}

class MockJournalViewDelegate: ExpectationDelegateClass, JournalViewDelegate {
    
    func didUpdate(journals: [GapInternational.Journal]) {
        expectation.fulfill()
    }
    
    func failedToFetchJournals(message: String) {
        self.message = message
        expectation.fulfill()
    }
    
}

class MockChapterListViewDelegate: ExpectationDelegateClass, ChapterListViewDelegate {
    
    func didUpdate(chapters: [GapInternational.Chapter]) {
        expectation.fulfill()
    }
    
    func failedToFetchChapters() {
        expectation.fulfill()
    }
    
    func chapter(error message: String) {
        self.message = message
        
    }
    
    
}

class MockChapterDetailViewDelegate: ExpectationDelegateClass, ChapterDetailDelegate {
    
    func didSelect(chapter: GapInternational.Chapter) {
        expectation.fulfill()
    }
    
    func didChapterComplete() {
        expectation.fulfill()
    }
    
    func journalSavedSuccess() {
        expectation.fulfill()
    }
    
    func didFailedToSaveJournal(message: String) {
        self.message = message
        expectation.fulfill()
    }
    
    
}
