//
//  ChapterListViewController.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import UIKit

class ChapterListViewController: UITableViewController {
    
    let cellId: String = "ChapterCell"
    
    let chapterModel: ChapterViewModel
    
    init(chapterModel: ChapterViewModel) {
        self.chapterModel = chapterModel
        super.init(style: .plain)
        self.chapterModel.chapterListDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .accentColor
        view.backgroundColor = .accentColor
        tableView.backgroundColor = .accentColor
        tableView.tintColor = .white
        tableView.separatorColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        chapterModel.fetchChapters()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapterModel.chapters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        var config = UIListContentConfiguration.valueCell()
        config.text = chapterModel.chapters[indexPath.row].chapterName
        config.textProperties.color = .white
        
        cell.backgroundColor = .accentColor
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chapterModel.selectChapter(at: indexPath.row)
    }

}

// MARK: - ChapterListViewDelegate
extension ChapterListViewController: ChapterListViewDelegate {
    
    func didUpdate(chapters: [Chapter]) {
        tableView.reloadData()
    }
    
    func failedToFetchChapters() {
        
    }
    
    func chapter(error message: String) {
        showAlert(with: message)
    }
    
}
