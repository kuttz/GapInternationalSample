//
//  JournalsViewController.swift
//  GapInternational
//
//  Created by Sreekuttan D on 22/07/23.
//

import UIKit

class JournalsViewController: UITableViewController {
        
    var journalModel: JournalFetchable
    
    init(journalModel: JournalFetchable) {
        self.journalModel = journalModel
        super.init(style: .plain)
        
        self.journalModel.journalDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.tintColor = .white
        tableView.register(JournalTableViewCell.self, forCellReuseIdentifier: JournalTableViewCell.cellId)
        
        journalModel.getAllJournals()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalModel.journals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JournalTableViewCell.cellId, for: indexPath) as! JournalTableViewCell
        
        let journal = journalModel.journals[indexPath.row]
         
        cell.chapterLabel.text = journal.chapterName
        cell.dateLabel.text = journal.formatedDate
        cell.commentLabel.text = journal.comment
        cell.backgroundColor = .clear
        cell.accessoryType = .none
        cell.tintColor = .white
        cell.selectionStyle = .none
        return cell
    }

}

// MARK: - JournalViewDelegate
extension JournalsViewController: JournalViewDelegate {
    
    func didUpdate(journals: [Journal]) {
        print("didUpdate(journals")
        tableView.reloadData()
    }
    
    func failedToFetchJournals(message: String) {
        debugPrint(message)
    }
    
}
