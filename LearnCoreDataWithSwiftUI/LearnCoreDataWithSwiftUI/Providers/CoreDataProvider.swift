//
//  CoreDataProvider.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        
        //register transform
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "ReminderModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing reminder model \(error)")
            }
        }
        
    }
}
