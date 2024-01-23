//
//  AddFriendView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI

struct AddFriendView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.words)
                    .textContentType(.name)
                Text("*Required")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            VStack(alignment: .leading) {
                TextField("Notes", text: $notes, axis: .vertical)
                    .textInputAutocapitalization(.sentences)
                Text("*Required")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            Button("Save") {
                if save() {
                    dismiss()
                }
            }
        }
        .navigationTitle("Add Friend")
    }
    
    func save() -> Bool {
        
        guard name != "" else { return false }
        guard notes != "" else { return false }
        
        let newFriend = Friend(name: name, notes: notes)
        modelContext.insert(newFriend)
        return true
    }
}

#Preview {
    AddFriendView()
}
