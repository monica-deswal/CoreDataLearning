//
//  MyListCellView.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import SwiftUI

struct MyListCellView: View {
    
    let myList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundStyle(Color(myList.color))
            Text(myList.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .opacity(0.4)
                .padding([.trailing], 10)
        }
    }
}

#Preview {
    MyListCellView(myList: PreviewData.myList)
}
