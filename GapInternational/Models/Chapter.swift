//
//  Chapter.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

struct Chapter: Codable, Identifiable {
    
    let chapterId: Int
    let chapterName: String
    let videoUrl: String
    var description: String?
    
    var id: Int {
        chapterId
    }
    
    enum CodingKeys: String, CodingKey {
        case chapterId = "ChapterId"
        case chapterName = "ChapterName"
        case videoUrl = "VideoUrl"
    }
}


extension Chapter {
    
    var chapterLevel: Int {
        chapterId
    }
    
    static var all: Resource<Response<[Chapter]>> {
        Resource(url: EndPoint.getChapter.url!)
    }
    
}
