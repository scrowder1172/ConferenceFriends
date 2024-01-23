//
//  AddFriendView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI
import PhotosUI

struct AddFriendView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var notes: String = ""
    
    @State private var photo: PhotosPickerItem?
    @State private var image: Image?
    
    var body: some View {
        Form {
            
            PhotosPicker(selection: $photo, matching: .images) {
                if let image {
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .border(.black)
                } else {
                    ContentUnavailableView {
                        Label("No Picture", systemImage: "photo.badge.plus")
                    } description: {
                        Text("Tap to import a photo")
                    }
                    .padding()
                    .border(.black)
                }
            }
            .onChange(of: photo) {
                Task {
                    if let imageData = try await photo?.loadTransferable(type: Data.self) {
                        if let uiImage: UIImage = UIImage(data: imageData) {
                            print("Image orientation: \(uiImage.imageOrientation)")
                            image = Image(uiImage: uiImage)
                        }
                    }
                }
            }
            
            Button {
                image = nil
                photo = nil
            } label: {
                Label(
                    title: {  },
                    icon: { Image(systemName: "trash") }
                )
                .font(.caption)
            }
            .accessibilityLabel("Delete image")
            
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
        
        Task {
            guard let imageData = try await photo?.loadTransferable(type: Data.self) else {
                let newFriend = Friend(name: name, notes: notes)
                modelContext.insert(newFriend)
                return
            }
            
            let newFriend = Friend(name: name, notes: notes, photo: imageData)
            modelContext.insert(newFriend)
        }
        
        
        
        return true
    }
}

#Preview {
    AddFriendView()
}
