//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 10.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
var folder: String

private lazy var tableView: CustomTableView<DetailTableViewCell, ToDo> = {
    
    let sortDescriptor = [NSSortDescriptor(key: "title", ascending: true)]
    let predicate = NSPredicate(format: "folder == %@", folder)
    let dataProvider = DataProvider<ToDo>(managedObjectContext: CoreDataManager.shared.managedObjectContext, sortDescriptors: sortDescriptor)
    let tableVieW = CustomTableView<DetailTableViewCell, ToDo>(dataProvider: dataProvider) { (cell, todo) in
        cell.model = todo
    } selectionHandler: { (todo) in
        print("\(todo.title ?? "")")
    }
    return tableVieW
}()
    private lazy var addNewItem: UIButton = {
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

init(folder: String) {
    self.folder = folder
    super.init(nibName: nil, bundle: nil)
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    @objc private func buttonClicked(_ sender: UIButton) {
        let vc = AddNewItemViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        setUpView()
        tableView.Fetch()
    }
  
    private func setUpView() {
        title = "To Do List"
        view.addSubview(tableView)
        view.addSubview(addNewItem)
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
            addNewItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addNewItem.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addNewItem.widthAnchor.constraint(equalToConstant: 44),
            addNewItem.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}

extension DetailViewController: AddNewItemViewControllerDelegate {
    func saveNewItem(item: String) {
        CoreDataManager.shared.saveToDo(folder: folder, todoItem: item)
        tableView.Fetch()
    }
   
}
