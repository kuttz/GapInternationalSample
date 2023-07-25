//
//  ChapterViewModel.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation
import AVKit

protocol ChapterListViewDelegate: AnyObject {
    
    func didUpdate(chapters: [Chapter])
    
    func failedToFetchChapters()
    
    func chapter(error message: String)
}

protocol ChapterDetailDelegate: AnyObject {
    
    func didSelect(chapter: Chapter)
    
    func didChapterComplete()
    
    func journalSavedSuccess()
    
    func didFailedToSaveJournal(message: String)
}

class ChapterViewModel: NSObject {
    
    let user: User
    
    fileprivate let webservice: WebserviceProtocol
    
    let journalModel: JournalFetchable
    
    private(set) var chapters: [Chapter] = []
    
    private(set) var currentChapter: Chapter?
        
    weak var chapterListDelegate: ChapterListViewDelegate?
    
    weak var chapterDetailDelegate: ChapterDetailDelegate?
    
    private(set) var player: AVPlayer = AVPlayer()
    
    init(user: User,
         journalModel: JournalFetchable,
         webservice: WebserviceProtocol) {
        self.user = user
        self.journalModel = journalModel
        self.webservice = webservice
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        journalModel.getAllJournals()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func fetchChapters() {
        Task {
            do {
                let chapters = try await webservice.load(resource: Chapter.all)
                Task { @MainActor in
                    self.chapters = chapters.result
                    chapterListDelegate?.didUpdate(chapters: chapters.result)
                    selectChapter(at: 0)
                }
            } catch {
                Task { @MainActor in
                    chapterListDelegate?.failedToFetchChapters()
                }
            }
        }
    }
    
    func selectChapter(at index: Int) {
        
        let maxUserLevel = userLevel()
        
        guard chapters.count > index else { return }
        guard index <= maxUserLevel else {
            chapterListDelegate?.chapter(error: "Chapter locked")
            return
        }
        let chapter = chapters[index]
        currentChapter = chapter
        guard let url = URL(string: chapter.videoUrl) else {
            return
        }
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: playerItem)
        chapterDetailDelegate?.didSelect(chapter: chapter)
    }
    
    func userLevel() -> Int {
        return journalModel.journals.map({ $0.level }).sorted().last ?? 0
    }
    
    @objc fileprivate func playerDidFinishPlaying() {
        chapterDetailDelegate?.didChapterComplete()
    }
    
    func saveJournal(comment: String?) {
        
        guard let currentChapter,
              let comment,
              !comment.isEmpty else {
            chapterDetailDelegate?.didFailedToSaveJournal(message: "Request failed")
            return
        }
        let journal = Journal(userName: user.userName,
                              chapterName: currentChapter.chapterName,
                              comment: comment,
                              level: currentChapter.chapterLevel,
                              date: nil)
        
        guard let request = journal.saveRequest else {
            chapterDetailDelegate?.didFailedToSaveJournal(message: "Request failed")
            return
        }
        
        Task {
            do {
                let response = try await webservice.load(resource: request)
                Task { @MainActor in
                    if response.isSuccess {
                        journalModel.getAllJournals()
                        chapterDetailDelegate?.journalSavedSuccess()
                    } else {
                        chapterDetailDelegate?.didFailedToSaveJournal(message: response.result)
                    }
                }
            } catch {
                Task { @MainActor in
                    chapterDetailDelegate?.didFailedToSaveJournal(message: "Request failed")
                }
            }
        }
    }
    
}
