//
//  ContentView.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 21/11/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            Text("Is Active: ")
                            user.isActive ? Image(systemName: "checkmark.circle") : Image(systemName: "xmark.circle")
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .navigationTitle("FriendFace")
            
        }
        .task {
            await loadData()
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
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
