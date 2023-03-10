//
//  Schrodinger_DiffEqApp.swift
//  Schrodinger DiffEq
//
//  Created by IIT PHYS 440 on 3/10/23.
//

import SwiftUI

@main
struct Schrodinger_DiffEqApp: App {
    @StateObject var plotData = PlotClass()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(plotData)
                .tabItem {
                    Text("Plot")
                }
        }
    }
}
