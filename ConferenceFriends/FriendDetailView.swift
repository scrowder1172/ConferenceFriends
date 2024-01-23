//
//  FriendDetailView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI
import SwiftData

struct FriendDetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let friend: Friend
    
    @State private var showingWarning: Bool = false
    @State private var showingDeletion: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(friend.name)
                .font(.title)
                .bold()
                .padding()
            
            ScrollView {
                if let photo: Data = friend.photo, let uiImage: UIImage = UIImage(data: photo) {
                    Image(uiImage: uiImage)
                        .resizable()
    //                    .frame(maxWidth: .infinity)
    //                    .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 20)
                        .frame(minWidth: UIScreen.main.bounds.width, minHeight: 400)
                        //.border(.red)
                } else {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .scaledToFit()
                }
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("Added \(friend.dateFormatted)")
                            .font(.caption)
                            .padding(.bottom, 20)
                    }
                    
                    HStack {
                        Text("Notes")
                            .font(.headline)
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    
                    HStack {
                        Text(friend.notes)
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Delete", systemImage: "trash.circle") {
                    showingWarning = true
                }
            }
        }
        .alert("Warning", isPresented: $showingWarning) {
            Button("OK") {
                modelContext.delete(friend)
                //presentationMode.wrappedValue.dismiss()
                showingDeletion = true
            }
            Button("Cancel") {}
        } message: {
            Text("Do you want to delete \(friend.name)?")
        }
        .alert("Friend Deleted", isPresented: $showingDeletion) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("\(friend.name) has been deleted.")
        }
    }
}

#Preview {
    do {
        let config: ModelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container: ModelContainer = try ModelContainer(for: Friend.self, configurations: config)
        let friend: Friend = Friend(name: "Sam", notes: "Person details")
        return FriendDetailView(friend: friend)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
//    FriendDetailView(friend: Friend(name: "Sam", notes: "Person details"))
}
