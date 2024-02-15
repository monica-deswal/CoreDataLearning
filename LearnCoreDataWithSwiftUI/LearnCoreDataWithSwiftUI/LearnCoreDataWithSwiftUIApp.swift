//
//  LearnCoreDataWithSwiftUIApp.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import SwiftUI

@main
struct LearnCoreDataWithSwiftUIApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // notification is granted
            } else {
                // display message to the user
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext
                              , CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
