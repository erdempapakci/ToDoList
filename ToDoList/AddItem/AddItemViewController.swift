//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 10.09.2022.
//

import UIKit
import CoreData

protocol AddNewItemViewControllerDelegate: AnyObject {
    func saveNewItem(item: String)
}

final class AddNewItemViewController: UIViewController {
    weak var delegate : AddNewItemViewControllerDelegate?
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Add"
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
        
    }()
    
    private lazy var titleField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Add New Item"
        
        return textField
    }()
    
    private lazy var saveButtton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonClicked(_:)), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @objc private func saveButtonClicked(_ sender: UIButton) {
        guard let text = titleField.text, !text.isEmpty else {
            return
        }
        delegate?.saveNewItem(item: text)
        dismiss(animated: true, completion: nil)
        
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        [titleLabel, titleField, saveButtton].forEach { (vieW) in
            view.addSubview(vieW)
        }
        setUpConstraint()
        
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            saveButtton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButtton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButtton.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            saveButtton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
