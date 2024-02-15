//
//  MyListView.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import SwiftUI

struct MyListView: View {
    
    let myLists: FetchedResults<MyList>
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            
            if myLists.isEmpty {
                Spacer()
                
                Text("No reminders found")
            } else {
                ForEach(myLists) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                                .foregroundStyle(colorScheme == .dark ? Color.offWhite : Color.darkGray)
                            Divider()
                        }
                    }.listRowBackground(colorScheme == .dark ? Color.red : Color.blue)
                    
                }.scrollContentBackground(.hidden)
                    .navigationDestination(for: MyList.self) { myList in
                        MyListDetailView(myList: myList)
                            .navigationTitle(myList.name)
                    }
            }
        }
    }
}

//#Preview {
//    MyListView()
//}
