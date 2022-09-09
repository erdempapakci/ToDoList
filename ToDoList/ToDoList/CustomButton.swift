//
//  CustomButton.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 10.09.2022.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.black, for: .normal)
        layer.shadowRadius = 15
        layer.borderWidth = 2
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        clipsToBounds = true
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
