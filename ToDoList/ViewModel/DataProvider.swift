//
//  DataProvider.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 9.09.2022.
//

import Foundation
import CoreData

protocol DataProviderDelegate: AnyObject {

    func didInsertItem(indexPath: IndexPath)
    func didDeleteItem(indexPath: IndexPath)
    
    
}

final class DataProvider<T: NSManagedObject>:NSObject, NSFetchedResultsControllerDelegate {
    
    weak var delegate: DataProviderDelegate?
    
    private var managedObjectContext: NSManagedObjectContext
    private var sortDescriptors: [NSSortDescriptor]
    private var predicate: NSPredicate?
    private lazy var request: NSFetchRequest<T> = {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.sortDescriptors = sortDescriptors
    }()
    
    init(managedObjectContext: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate? = nil) {
        self.sortDescriptors = sortDescriptors
        self.managedObjectContext = managedObjectContext
        self.predicate = predicate
        
        super.init()
        Fetch()
        
    }
    
    func Fetch() {

        
    }
    
    
    
}
