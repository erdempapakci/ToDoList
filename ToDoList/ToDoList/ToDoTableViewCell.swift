//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 9.09.2022.
//

import UIKit

final class ToDoTableViewCell: UITableViewCell {
    
    var model: Folder? {
        didSet {
            if let folder = model  {
                folderTitle.text = folder.title
            }
        }
    }
    
    private lazy var folderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    func setUpView() {
        contentView.addSubview(folderTitle)
        setUpConstraint()
        
    }
    
    func setUpConstraint() {
        NSLayoutConstraint.activate([
            folderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            folderTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            folderTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            folderTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
