//
//  CustomOperators.swift
//  LearnCoreDataWithSwiftUI
//
//  Created by Monica Deshwal on 09/02/24.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
