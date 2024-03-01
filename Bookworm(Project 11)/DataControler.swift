//
//  DataControler.swift
//  Bookworm(Project 11)
//
//  Created by mac on 17.04.2023.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
