//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 9.09.2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Error found: \(error), \(error.userInfo)")
            
            }
        }
        return container
        
        
    }()
    
    private init() {
        managedObjectContext = self.persistentContainer.viewContext
        
        
        
    }
    private func saveContest() {
        if managedObjectContext.hasChanges {
            
            do {
                try managedObjectContext.save()
            } catch let err as NSError {
                fatalError("\(err)")
                
            }
        }
        
        
    }
}
