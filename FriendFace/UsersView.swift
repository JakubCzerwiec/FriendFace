//
//  UsersView.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 25/11/2024.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            Text("Is Active: ")
                            Text("\(user.isActive ? Image(systemName: "checkmark.circle") : Image(systemName: "xmark.circle"))")
                                .foregroundStyle(user.isActive ? .green : .red)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .navigationTitle("FriendFace")
        }
    }
    
    init(sortOrder: [SortDescriptor<User>]) {
         _users = Query(sort: sortOrder)
    }
}

#Preview {
    UsersView(sortOrder: [SortDescriptor(\User.name)])
}
