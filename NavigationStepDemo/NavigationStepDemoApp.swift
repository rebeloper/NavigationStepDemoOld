//
//  NavigationStepDemoApp.swift
//  NavigationStepDemo
//
//  Created by Alex Nagy on 17.05.2021.
//

import SwiftUI

@main
struct NavigationStepDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().embedInStackNavigationView()
        }
    }
}
