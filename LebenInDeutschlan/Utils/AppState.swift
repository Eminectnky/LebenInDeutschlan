//
//  AppState.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 30.12.2024.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var selectedState: String = "Bayern" 
}
