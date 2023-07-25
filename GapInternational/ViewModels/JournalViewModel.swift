//
//  JournalViewModel.swift
//  GapInternational
//
//  Created by Sreekuttan D on 23/07/23.
//

import Foundation

protocol JournalViewDelegate: AnyObject {
    
    func didUpdate(journals: [Journal])
    
    func failedToFetchJournals(message: String)
}

protocol JournalFetchable: AnyObject {
    
    var journals: [Journal] { get }
    
    var journalDelegate: JournalViewDelegate? {set get}
    
    func getAllJournals()
    
    
    
}

class JournalViewModel: NSObject, JournalFetchable {
    
    let user: User
    
    fileprivate let webservice: WebserviceProtocol
    
    private(set) var journals: [Journal] = []

    weak var journalDelegate: JournalViewDelegate?
    
    init(user: User, webservice: WebserviceProtocol) {
        self.user = user
        self.webservice = webservice
        super.init()
    }
    
    func getAllJournals() {
        
        guard let request = Journal.getAll(for: user.userName) else {
            return
        }
        
        Task {
            do {
                let journals = try await webservice.load(resource: request)
                Task { @MainActor in
                    self.journals = journals
                    journalDelegate?.didUpdate(journals: journals)
                }
            } catch {
                Task { @MainActor in
                    journalDelegate?.failedToFetchJournals(message: "Request failed")
                }
            }
        }
    }
    
}
