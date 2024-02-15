//
//  ReminderStatsBuilder.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 15/02/24.
//

import Foundation
import SwiftUI


enum ReminderStatType {
    
    case today
    case all
    case schedule
    case completed
}

struct ReminderStatsValue {
    var todayCount: Int = 0
    var scheduleCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct ReminderStatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) ->  ReminderStatsValue {
        
        let reminderArray = myListResults.map {
            $0.remindersArray
        }.reduce([], +)
        
        let todaysCount = calculateTodaysCount(reminders: reminderArray)
        print("the value of todays count \(todaysCount)")
        let scheduleCount = calculateScheduledCount(reminders: reminderArray)
        let completedCount = calculateCompletedCount(remiders: reminderArray)
        let allCount = calculateAllCount(reminders: reminderArray)
        
        return ReminderStatsValue(todayCount: todaysCount
                                  , scheduleCount: scheduleCount
                                  , allCount: allCount
                                  , completedCount: completedCount)
        
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ? result+1 : result
        }
    }
    
    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result+1 : result
        }
    }
    
    private func calculateCompletedCount(remiders: [Reminder]) -> Int {
        return remiders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result+1 : result
        }
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result+1 : result
        }
    }
}
