//
//  AddFriendView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI

struct AddFriendView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Notes", text: $notes)
            Button("Save") {
                dismiss()
            }
        }
        .navigationTitle("Add Friend")
    }
}

#Preview {
    AddFriendView()
}
