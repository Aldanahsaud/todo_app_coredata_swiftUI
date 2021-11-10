//
//  CoreDataManagerr.swift
//  ToDoHomework#2
//
//  Created by AlDanah Aldohayan on 07/11/2021.
//

import Foundation
import CoreData

class CoreDataManagerr {
    
    let persistantContainer: NSPersistentContainer
    static let shared: CoreDataManagerr = CoreDataManagerr()
    
    private init(){
        self.persistantContainer = NSPersistentContainer(name: "DataModel")
        persistantContainer.loadPersistentStores { deescription, error in
            if let error = error {
                fatalError("Unable to load\(error.localizedDescription)")
            }
        }
    }
}
