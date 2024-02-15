//
//  MyListDetailView.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import SwiftUI

struct MyListDetailView: View {
    
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getReminderByList(myList: myList))
    }
    
    var body: some View {
        VStack {
           
            //Display list of reminder
            //print(reminderResults.count)
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }.foregroundStyle(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("New Reminder", isPresented: $openAddReminder) {
            
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {
                
            }
            Button("Done"){
                if isFormValid {
                    //Save reminder to my list
                    do {
                        
                        try ReminderService.saveReminderToMyList(mylist: self.myList, reminderTitle: title)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }

    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
