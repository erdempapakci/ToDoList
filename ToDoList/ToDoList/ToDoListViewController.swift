//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 9.09.2022.
//

import UIKit
import CoreData
final class ToDoListViewController: UIViewController {
    
    private lazy var tableView: CustomTableView<ToDoTableViewCell, Folder> = {
        let sortDescriptor = [NSSortDescriptor(key: "title", ascending: true)]
        let dataProvider = DataProvider<Folder>(managedObjectContext: CoreDataManager.shared.managedObjectContext, sortDescriptors: sortDescriptor)
        let tableView = CustomTableView<ToDoTableViewCell, Folder>(dataProvider: dataProvider) { (cell, folder) in
            cell.model = folder
        } selectionHandler: { [weak self] (folder) in
            guard let strongSelf = self, let folderTitle = folder.title else {
                return
            }
            print(folderTitle)
        }
        return tableView


    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tableView.Fetch()
    }
    
    @objc private func buttonClicked(_ sender: UIButton) {
        let vc = AddNewItemViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    private func setUpView() {
        title = "To Do List"
        view.addSubview(tableView)
        view.addSubview(addButton)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            addButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension ToDoListViewController: AddNewItemViewControllerDelegate{
    func saveNewItem(item: String) {
        CoreDataManager.shared.saveFolder(name: item)
        tableView.Fetch()
    }
    
    
    
}
