//
//  JournalTableViewCell.swift
//  GapInternational
//
//  Created by Sreekuttan D on 22/07/23.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    
    static let cellId = "JournalTableViewCell"
    
    var chapterLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topStack = UIStackView(arrangedSubviews: [chapterLabel, dateLabel])
        topStack.axis = .horizontal
        topStack.distribution = .fillEqually
        topStack.alignment = .fill
        topStack.spacing = 8
        
        let stack = UIStackView(arrangedSubviews: [topStack, commentLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
