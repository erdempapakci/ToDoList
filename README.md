<h1 align="center">ToDoList</h1>
<p align="center">

## Introduction

ToDoList is a basic ToDoList App which has simple UI. But the main idea for this project is coded fully Programmatically without Storyboard.

## CoreData Manager

```javascript 
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
    internal func saveContext() {
        if managedObjectContext.hasChanges {
            
            do {
                try managedObjectContext.save()
            } catch let err  {
                let error = err as NSError
                fatalError("\(error), \(error.userInfo)")
            }
        }
    }
}
 ```
 ## Data Source
 
```javascript 
final class DataSource<Cell: UITableViewCell, Model: NSManagedObject> : NSObject, UITableViewDataSource {
    
    var cellID: String
    var dataProvider: DataProvider<Model>
    var tableView: UITableView?
    var configCell: (Cell, Model) -> Void
    
    init(cellID: String, dataProvider: DataProvider<Model>, configCell: @escaping (Cell, Model) -> Void) {
        self.cellID = cellID
        self.dataProvider = dataProvider
        self.configCell = configCell
        
        super.init()
        
        self.dataProvider.delegate = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.rowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        let model = dataProvider.objectAtIndex(indexPath: indexPath)
        configCell(cell, model)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataProvider.deleteItem(indexPath: indexPath)
            tableView.reloadData()
        }
    }
}
 ```
 
 
 
