//
//  DetailTableViewCell.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 10.09.2022.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {
    var model: ToDo? {
        didSet {
            if let item = model {
                todoTitle.text = item.title
            }
        }
    }
    private lazy var todoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
    
    private func setUpView() {
        contentView.addSubview(todoTitle)
        setUpConstraints()
        
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            todoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            todoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            todoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            todoTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
    }
}
