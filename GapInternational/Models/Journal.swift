//
//  Journal.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

struct Journal: Codable {
    
    let userName: String
    let chapterName: String
    let comment: String
    let level: Int
    let date: String?
    
    init(userName: String, chapterName: String, comment: String, level: Int, date: String? = nil) {
        self.userName = userName
        self.chapterName = chapterName
        self.comment = comment
        self.level = level
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case chapterName = "ChapterName"
        case comment = "Comment"
        case level = "Level"
        case date = "Date"
    }
}

extension Journal {
    
    var formatedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy hh:mm:ss a"
        guard let dateString = self.date,
              let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = "MMM d, yyyy, hh:mm:ss a"
        return dateFormatter.string(from: date)
    }

    var saveRequest: Resource<Response<String>>? {
        guard let url = EndPoint.saveJournal.url,
              let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return Resource(url: url, method: .post(data))
    }
    
    static func getAll(for user: String) -> Resource<[Journal]>? {
        
        guard let url = EndPoint.getJournal.url else { return nil }

        return Resource(url: url, method: .get([URLQueryItem(name: "UserName", value: user)]))
    }

}
