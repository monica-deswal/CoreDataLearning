//
//  ReminderListView.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetails: Bool = false
    
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditCofig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
            try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
        
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder: reminder)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        
                        switch event {
                            
                        case .onInfo:
                            print("onInfo")
                            showReminderDetails = true
                        case .onCheckedChanged(let reminder, let isCompleted):
                            print("onCheckedChange")
                            reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                        case .onSelect(let reminder):
                            print("on selected")
                            selectedReminder = reminder
                        }
                        
                    }
                }.onDelete(perform: deleteReminder)
                }
        }.sheet(isPresented: $showReminderDetails) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}


// #Preview {
//     
//     struct ReminderListViewContainer: View {
//         
//         @FetchRequest(sortDescriptors: [])
//         private var reminderResults: FetchedResults<Reminder>
//         
//         var body: some View {
//             ReminderListView(reminders: reminderResults)
//         }
//     }
//     
//     ReminderListViewContainer()
//         .environment(\.managedObjectContext
//                       ,CoreDataProvider.shared.persistentContainer.viewContext)
// }

