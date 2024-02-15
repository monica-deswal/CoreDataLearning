//
//  HomeView.swift
//  CoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .schedule))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .completed))
    private var completedResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValue()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    
                        HStack {
                            
                            NavigationLink {
                                
                                ReminderListView(reminders: todayResults)
                            } label: {
                                ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount)
                            }

                            NavigationLink {
                                
                                ReminderListView(reminders: scheduledResults)
                            } label: {
                                ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduleCount, iconColor: .red)
                            }
                            
                        }
                    
                    HStack {
                        
                        NavigationLink {
                            
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .secondary)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                            
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                        }
                    }
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    
                    MyListView(myLists: myListResults)
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity,
                                   alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }.onChange(of: search, perform: { searchTerm in
                
                searching = !searchTerm.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
                
            }).overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            }
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                         
                    }
                }
            }.padding()
        }.searchable(text: $search)
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
