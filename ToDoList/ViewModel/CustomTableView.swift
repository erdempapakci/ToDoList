//
//  TableView.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 9.09.2022.
//

import UIKit
import CoreData

final class CustomTableView<Cell: UITableViewCell, Model: NSManagedObject>: UITableView, UITableViewDelegate {
    
    private var cellID = String(describing: Cell.self)
    private var configCell: (Cell, Model) -> Void
    private var selectionHandler: (Model) -> Void
    
    private var dataProvider: DataProvider<Model>
    
    private lazy var modelDataSource: DataSource<Cell, Model> = {
        return DataSource<Cell, Model>(cellID: cellID, dataProvider: dataProvider, configCell: configCell)
        
    }()
    init(dataProvider:DataProvider<Model>, configCell: @escaping (Cell, Model) -> Void, selectionHandler: @escaping (Model) -> Void) {
        self.dataProvider = dataProvider
        self.configCell = configCell
        self.selectionHandler = selectionHandler
        
        super.init(frame: .zero, style: .plain)
        
        self.delegate = self
        self.dataSource = modelDataSource
        self.register(Cell.self, forCellReuseIdentifier: cellID)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tableFooterView = UIView()
        self.modelDataSource.tableView = self
        Fetch()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Fetch() {
        dataProvider.Fetch()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataProvider.objectAtIndex(indexPath: indexPath)
        selectionHandler(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
