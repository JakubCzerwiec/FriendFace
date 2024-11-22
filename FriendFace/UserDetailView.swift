//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 22/11/2024.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
            VStack {
                Text(user.name)
                    .font(.title)
                Text("Joined: \(user.formattedRegisteredDate)")

                List {
                    Section {
                        Text("Friends:")
                    }
                    .frame(maxWidth: .infinity)
                    ForEach(user.friends, id: \.id) { friend in
                        Text(friend.name)
                    }
                }
            }
    }
}

#Preview {
    UserDetailView(user: User(id: UUID(), isActive: true, name: "John", age: 0, company: "", email: "", address: "", about: "", tags: [""], friends: []))
}
