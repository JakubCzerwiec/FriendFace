//
//  User.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 21/11/2024.
//

import Foundation

struct User: Codable, Hashable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date?
    var tags: [String]
    var friends: [Friend]
    var formattedRegisteredDate: String {
        registered?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
     }
}

