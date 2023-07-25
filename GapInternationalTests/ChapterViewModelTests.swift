//
//  ChapterViewModelTests.swift
//  GapInternationalTests
//
//  Created by Sreekuttan D on 23/07/23.
//

import XCTest
@testable import GapInternational

final class ChapterViewModelTests: XCTestCase {
    
    let user: User = User(userName: "TestUser", password: "TestUser@123")
    
    var mockJournalModel: MockJournalModel = MockJournalModel()
    
    
    func testInitWithUser() {
        
        let sut: ChapterViewModel = ChapterViewModel(user: user,
                                                     journalModel: mockJournalModel,
                                                     webservice: DummyChapterWebService())
    
        XCTAssertNotNil(sut.user)
        
        XCTAssertEqual(sut.user.userName, "TestUser")
        
    }
    
    func testGetAllChaptersSuccess() {
        
        let expectation = self.expectation(description: "GetAllChaptersSuccess")
        let mockDelegate = MockChapterListViewDelegate(expectation: expectation)
        let sut: ChapterViewModel = ChapterViewModel(user: user,
                                                     journalModel: mockJournalModel,
                                                     webservice: DummyChapterWebService())
        sut.chapterListDelegate = mockDelegate
        sut.fetchChapters()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(sut.chapters.isEmpty)
        
        XCTAssertEqual(sut.currentChapter?.chapterId, 1)
        
        XCTAssertEqual(sut.currentChapter?.chapterName, "Chapter 00 Section 1")
                
        XCTAssertNil(mockDelegate.message)
        
    }
    
    func testUserLevel() {
        
        let expectation = self.expectation(description: "UserLevelSuccess")
        let mockDelegate = MockJournalViewDelegate(expectation: expectation)
        mockJournalModel.journalDelegate = mockDelegate
        let sut: ChapterViewModel = ChapterViewModel(user: user,
                                                     journalModel: mockJournalModel,
                                                     webservice: DummyChapterWebService())
                
        waitForExpectations(timeout: 5, handler: nil)
        
        let level = sut.userLevel()
        
        XCTAssertFalse(sut.journalModel.journals.isEmpty)
                
        XCTAssertEqual(level, 3)
        
        XCTAssertNil(mockDelegate.message)
        
    }
    
    func testSelectChapterSuccess() {
        let expectation = self.expectation(description: "SelectChapterSuccess")
        let mockDelegate = MockChapterListViewDelegate(expectation: expectation)
        let sut: ChapterViewModel = ChapterViewModel(user: user,
                                                     journalModel: mockJournalModel,
                                                     webservice: DummyChapterWebService())
        sut.chapterListDelegate = mockDelegate
        sut.fetchChapters()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        sut.selectChapter(at: 1)
        
        XCTAssertNotNil(sut.currentChapter)
        
        XCTAssertEqual(sut.currentChapter?.id, sut.chapters[1].id)
        
        XCTAssertNotEqual(mockDelegate.message, "Chapter locked")
    }
    
    func testSelectChapterFail() {
        let expectation = self.expectation(description: "SelectChapterFail")
        let mockDelegate = MockChapterListViewDelegate(expectation: expectation)
        let sut: ChapterViewModel = ChapterViewModel(user: user,
                                                     journalModel: mockJournalModel,
                                                     webservice: DummyChapterWebService())
        sut.chapterListDelegate = mockDelegate
        sut.fetchChapters()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        sut.selectChapter(at: 4)
        
        XCTAssertNotNil(sut.currentChapter)
        
        XCTAssertNotEqual(sut.currentChapter?.id, sut.chapters[4].id)
        
        XCTAssertEqual(mockDelegate.message, "Chapter locked")
    }
    
}

class MockJournalModel: JournalFetchable {
    
    var journals: [Journal] = []
    
    var journalDelegate: JournalViewDelegate?
    
    func getAllJournals() {
        sleep(2)
        journals = DummyJournalWebService().dummyJournals
        journalDelegate?.didUpdate(journals: journals)
    }
    
}
