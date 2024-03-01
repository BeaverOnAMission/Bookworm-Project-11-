//
//  Bookworm_Project_11_App.swift
//  Bookworm(Project 11)
//
//  Created by mac on 17.04.2023.
//

import SwiftUI

@main
struct Bookworm_Project_11_App: App {
    @StateObject private var datacontroller = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
        }
    }
}
