//
//  CoreDataManager+Extensions.swift
//  ToDoList
//
//  Created by Erdem Papakçı on 9.09.2022.
//

import Foundation
import CoreData
extension CoreDataManager{
    func saveFolder(name: String) {
        let folder = Folder(context: managedObjectContext)
        folder.title = name
        saveContext()
    }
    func saveToDo(folder:String, todoItem:String) {
        let toDo = ToDo(context: managedObjectContext)
        toDo.folder = folder
        toDo.title = todoItem
        saveContext()
    }
}
