//
//  ContentView.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 21/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State var users: [User] = []
    
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.registered)
    ]
    
    var body: some View {
        NavigationStack {
            UsersView(sortOrder: sortOrder)
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.registered)
                                ])
                            Text("Sort by registered date")
                                .tag([
                                    SortDescriptor(\User.registered),
                                    SortDescriptor(\User.name)
                                ])
                            Text("Sort by age (from youngest)")
                                .tag([
                                    SortDescriptor(\User.age)
                                ])
                            Text("Sort by age (from oldest)")
                                .tag([
                                    SortDescriptor(\User.age, order: .reverse)
                                ])
                        }
                    }
                }
        }

        .task {
            await loadData()
            for user in users {
                modelContext.insert(user)
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid url")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse.self
                do {
                   try modelContext.delete(model: User.self)
                }

            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
