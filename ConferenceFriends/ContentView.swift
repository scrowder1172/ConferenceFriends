//
//  ContentView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\Friend.name)
    ]) var friends: [Friend]
    
    @State private var showingAddFriend: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(friends) { friend in
                        
                        NavigationLink {
                            VStack {
                                
                                if let photo: Data = friend.photo, let uiImage: UIImage = UIImage(data: photo) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                } else {
                                    Image(systemName: "face.smiling")
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                }
                                
                                
                                Text(friend.name)
                                    .font(.title)
                                Text(friend.notes)
                                Text(friend.dateFormatted)
                                Button("Delete") {
                                    modelContext.delete(friend)
                                }
                            }
                        } label: {
                            VStack {
                                if let photo: Data = friend.photo, let uiImage: UIImage = UIImage(data: photo) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                } else {
                                    Image(systemName: "face.smiling")
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                }
                                Text(friend.name)
                                    .font(.caption)
                            }
                            
                        }
                        
                    }
                }
            }
            .navigationTitle("Conference Friends")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        showingAddFriend = true
                    }
                }
            }
            .sheet(isPresented: $showingAddFriend) {
                AddFriendView()
            }
        }
    }
    
    func deleteFriend(at offsets: IndexSet) {
        for offset in offsets {
            let friend = friends[offset]
            modelContext.delete(friend)
        }
    }
}

#Preview {
    ContentView()
}
