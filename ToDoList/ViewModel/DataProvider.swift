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

final class DataProvider<Model: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    
    weak var delegate: DataProviderDelegate?
    
    private var managedObjectContext: NSManagedObjectContext
    private var sortDescriptor: [NSSortDescriptor]
    private var predicate: NSPredicate?
    
    private lazy var request: NSFetchRequest<Model> = {
        let request = NSFetchRequest<Model>(entityName: String(describing: Model.self))
        request.sortDescriptors = sortDescriptor
        
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        return request
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController<Model> = {
        let fetchedResults = NSFetchedResultsController<Model>(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResults.delegate = self
        
        return fetchedResults
        
    }()
    
    init(managedObjectContext: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate? = nil) {
        self.sortDescriptor = sortDescriptors
        self.managedObjectContext = managedObjectContext
        self.predicate = predicate
        
        super.init()
        Fetch()
        
    }
    
    func Fetch() {
        do {
            try fetchedResultController.performFetch()
        } catch let erroR{
            print(erroR.localizedDescription)
            
        }
    }
    func objectAtIndex(indexPath: IndexPath) -> Model {
        return fetchedResultController.object(at: indexPath)
        
        
    }
    func rowsInSection(section: Int) -> Int {
        
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    func numberOfSections() -> Int {
        return fetchedResultController.sections?.count ?? 1
        
    }
    func deleteItem(indexPath: IndexPath) {
        let item = objectAtIndex(indexPath: indexPath)
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            if let idPath = newIndexPath {
                delegate?.didInsertItem(indexPath: idPath)
            } else if type == .delete {
                if let idPath = newIndexPath {
                    delegate?.didDeleteItem(indexPath: idPath)
                    
                }
                
            }
            
        }
    }
    
}
