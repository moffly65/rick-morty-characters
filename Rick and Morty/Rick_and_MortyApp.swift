//
//  Rick_and_MortyApp.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI

@main
struct Rick_and_MortyApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        }
    }
}
