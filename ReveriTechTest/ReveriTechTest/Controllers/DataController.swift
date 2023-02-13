//
//  DataController.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import CoreData
import SwiftUI

/// A environment class responsible for managing our CoreData by handling saving,
/// working with sample data, tracking awards and counting fetch requests.
class DataController: ObservableObject {
    /// A CloudKit container used to store all our data.
    let container: NSPersistentCloudKitContainer
    
    /// The UserDefaults suite where we're saving used data
    let defaults: UserDefaults
    
    /// Initializes a data controller, either in memory (for temporary use such as testing and previewing),
    /// or on permanent storage (for use in regular app runs.)
    ///
    /// Defaults to permanent storage.
    /// - Parameter inMemory: Whether to store this data in temporary memory or not.
    /// - Parameter defaults: The UserDefaults suite where user data should be stored.
    init(inMemory: Bool = false, enableTesting: Bool = false, defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        container = NSPersistentCloudKitContainer(name: "Main", managedObjectModel: Self.model)
        
        // For testing and previewing purposes, we create a temporary,
        // in-memory database by writing to /dev/null so our data is
        // destroyed after the app finishes running.
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
            
            self.container.viewContext.automaticallyMergesChangesFromParent = true
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
#if DEBUG
            if CommandLine.arguments.contains("enable-testing") || enableTesting {
                UIView.setAnimationsEnabled(false)
            }
#endif
            
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        
        return dataController
    }()
    
    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "Main", withExtension: "momd") else {
            fatalError("Failed to locate model file.")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model file.")
        }
        
        return managedObjectModel
    }()
    
    
    /// Saves our CoreData context iff there are changes. This silently ignores
    /// any errors caused by saving, but this should be fine because our
    /// attributes are options.
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func deleteAll() {
        let entityNames = [
            "Product"
        ]
        
        for entityName in entityNames {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            delete(request)
        }
    }
    
    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        if let delete = try? container.viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
            let changes = [NSDeletedObjectsKey: delete.result as? [NSManagedObjectID] ?? []]
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: changes,
                into: [container.viewContext]
            )
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }
    
    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }
    
    func results<T: NSManagedObject>(for fetchRequest: NSFetchRequest<T>) -> [T] {
        return (try? container.viewContext.fetch(fetchRequest)) ?? []
    }
}

