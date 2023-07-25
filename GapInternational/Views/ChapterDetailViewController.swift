//
//  ChapterDetailViewController.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import UIKit
import AVKit

class ChapterDetailViewController: UIViewController {
    
    let chapterModel: ChapterViewModel
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var descriptionTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    fileprivate var playerViewController: AVPlayerViewController = AVPlayerViewController()
    
    init(chapterModel: ChapterViewModel) {
        self.chapterModel = chapterModel
        super.init(nibName: nil, bundle: nil)
        
        self.chapterModel.chapterDetailDelegate = self
        
       
        playerViewController.player = chapterModel.player
        addChild(playerViewController)
//        view.addSubview(playerViewController.view)
                
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, playerViewController.view, descriptionTextView])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        view.backgroundColor = .systemBackground
        playerViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            playerViewController.view.widthAnchor.constraint(equalTo: playerViewController.view.heightAnchor, multiplier: 16/9)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let journalButton = UIBarButtonItem(title: "Journal", style: .plain, target: self, action: #selector(journals))
        journalButton.tintColor = .accentColor
        navigationItem.rightBarButtonItem = journalButton
        navigationItem.title = "GapInternational"
    }
    
    fileprivate func addComment() {
        let alert = UIAlertController(title: "Leave a comment",
                                      message: "What did you think about the chapter?",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your comment"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields?.first
            self.chapterModel.saveJournal(comment: textField?.text)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in}))
        
        self.present(alert, animated: true)
    }
    
    @objc fileprivate func journals() {
        let journalsVC = JournalsViewController(journalModel: chapterModel.journalModel)
        show(journalsVC, sender: self)
    }

}

// MARK: - ChapterDetailDelegate
extension ChapterDetailViewController: ChapterDetailDelegate {
    
    func journalSavedSuccess() {
        
    }
    
    func didFailedToSaveJournal(message: String) {
        showAlert(with: message)
    }

    func didSelect(chapter: Chapter) {
        titleLabel.text = chapter.chapterName
        descriptionTextView.text = chapter.description
        playerViewController.player = chapterModel.player
    }
    
    func didChapterComplete() {
        addComment()
    }

}
