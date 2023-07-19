//
//  McKinley_Rice_TaskApp.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/17.
//

import SwiftUI

@main
struct McKinley_Rice_TaskApp: App {
    
    @AppStorage(StorageKeys.TOKEN) private var savedToken: String = ""
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            if savedToken.isEmpty {
                LoginView()
            } else {
                HomeView()
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                print("Saved Token :\(savedToken)")
            }
        }
    }
}

/**
 
 APPStorage is not secure need to store it in a keychain for better security for now I am saving in a userdefaukts for demo purpose.
 
 */
