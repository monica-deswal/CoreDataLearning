//
//  ReminderStatsView.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 15/02/24.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon: String
    let title: String
    let count: Int?
    var iconColor: Color = .blue
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.title)
                    
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }.padding()
                .background(colorScheme == .dark ? Color.darkGray : Color.offWhite)
                .foregroundStyle(colorScheme == .dark ? Color.offWhite : Color.darkGray)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}

#Preview {
    Group {
        ReminderStatsView(icon: "calendar", title: "Today", count: 8)
        
    }
    
}
