//
//  SwiftUIMapAppApp.swift
//  SwiftUIMapApp
//
//  Created by Ayaan Rushil Siddiqui on 2/13/23.
//

import SwiftUI

@main
struct SwiftUIMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(vm)
        }
    }
}
