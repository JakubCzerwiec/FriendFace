//
//  Test.swift
//  FriendFace
//
//  Created by Jakub Czerwiec  on 21/11/2024.
//

import SwiftUI

//struct Response: Codable {
//    var results: [Result]
//}

struct Result: Codable {
    var name: String

}

struct Test: View {
    @State private var results: [Result] = []

    var body: some View {
        List(results, id: \.name) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
       //         Text(item.collectionName)
            }
        }
        .task {
            await loadData()
            print(results)
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Result].self, from: data) {
                results = decodedResponse.self
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    Test()
}
