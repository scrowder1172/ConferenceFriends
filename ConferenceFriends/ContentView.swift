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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    
                    NavigationLink {
                        VStack {
                            Image(systemName: "face.smiling")
                                .resizable()
                                .frame(width: 200, height: 200)
                            Text(friend.name)
                                .font(.title)
                            Text(friend.notes)
                            Text(friend.dateFormatted)
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text(friend.name)
                                .font(.title)
                        }
                    }
                    
                }
                .onDelete(perform: deleteFriend)
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
