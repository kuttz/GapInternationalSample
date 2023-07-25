//
//  ChapterViewController.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import UIKit

class ChapterViewController: UISplitViewController {
    
    var chapterModel: ChapterViewModel
    
    init(chapterModel: ChapterViewModel) {
        self.chapterModel = chapterModel
        super.init(style: .doubleColumn)
        
        preferredDisplayMode = .oneOverSecondary
        preferredSplitBehavior = .automatic
        
        let listVC = ChapterListViewController(chapterModel: chapterModel)
        let detailVC = ChapterDetailViewController(chapterModel: chapterModel)
        
        self.viewControllers = [listVC, detailVC]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
