//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 21/11/2024.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
