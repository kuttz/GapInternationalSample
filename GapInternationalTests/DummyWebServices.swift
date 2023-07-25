//
//  DummyWebServices.swift
//  GapInternationalTests
//
//  Created by Sreekuttan D on 23/07/23.
//

import Foundation
@testable import GapInternational

class DummyUserWebService: WebserviceProtocol {
    
    func load<T: Codable>(resource: Resource<T>) async throws -> T {
        
        sleep(2)
        
        switch resource.url.lastPathComponent {
        case "CreateUserAccount":
            return Response(result: "success") as! T
        case "UserLogin":
            return Response(result: "Login successful") as! T
        default:
            throw NetworkError.invalidResponse
        }
    }
    
}

class DummyJournalWebService: WebserviceProtocol {
    
    func load<T: Codable>(resource: Resource<T>) async throws -> T {
        
        sleep(2)
        
        switch resource.url.lastPathComponent {
        case "GetJournal":
            return dummyJournals as! T
        default:
            throw NetworkError.invalidResponse
        }
    }
    
}

extension DummyJournalWebService {
    
    var userName: String {
        return "TestUser"
    }
    
    var dummyJournals: [Journal] {
        [
            Journal(userName: userName,
                    chapterName: "Chapter 00 Section 1",
                    comment: "Nice one",
                    level: 1,
                    date: "7/18/2023 1:05:56 PM"),
            Journal(userName: userName,
                    chapterName: "Chapter 00 Section 2",
                    comment: "Get started",
                    level: 2,
                    date: "7/19/2023 3:05:56 PM"),
            Journal(userName: userName,
                    chapterName: "Chapter 00 Section 3",
                    comment: "Another nice one",
                    level: 3,
                    date: "7/20/2023 5:05:56 PM")
        ]
    }
    
}

class DummyChapterWebService: WebserviceProtocol {
    
    func load<T: Codable>(resource: Resource<T>) async throws -> T {
        
        sleep(2)
        
        switch resource.url.lastPathComponent {
        case "GetChapter":
            return Response(result: dummyChapters) as! T
        case "SaveJournal":
            return Response(result: "success") as! T
        default:
            throw NetworkError.invalidResponse
        }
    }
    
}

extension DummyChapterWebService {
    
    var dummyChapters: [Chapter] {
        [
            Chapter(chapterId: 1,
                    chapterName: "Chapter 00 Section 1",
                    videoUrl: "https://gapinternationalvideos.s3.us-east-2.amazonaws.com/_FINAL/CH00/SECTION_1/CH00_Aclitimize_BD1_10-6-11.mp4"),
            Chapter(chapterId: 2,
                    chapterName: "Chapter 00 Section 2",
                    videoUrl: "https://gapinternationalvideos.s3.us-east-2.amazonaws.com/_FINAL/CH00/SECTION_1/CH00_Aclitimize_BD1_10-6-11.mp4"),
            Chapter(chapterId: 3,
                    chapterName: "Chapter 00 Section 3",
                    videoUrl: "https://gapinternationalvideos.s3.us-east-2.amazonaws.com/_FINAL/CH00/SECTION_1/CH00_Aclitimize_BD1_10-6-11.mp4"),
            Chapter(chapterId: 4,
                    chapterName: "Chapter 01 Section 1",
                    videoUrl: "https://gapinternationalvideos.s3.us-east-2.amazonaws.com/_FINAL/CH00/SECTION_1/CH00_Aclitimize_BD1_10-6-11.mp4"),
            Chapter(chapterId: 5,
                    chapterName: "Chapter 02 Section 1",
                    videoUrl: "https://gapinternationalvideos.s3.us-east-2.amazonaws.com/_FINAL/CH00/SECTION_1/CH00_Aclitimize_BD1_10-6-11.mp4"),
        ]
    }
    
}
