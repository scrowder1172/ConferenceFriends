//
//  FriendDetailView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI
import SwiftData
import MapKit

struct FriendDetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let friend: Friend
    
    @State private var showingWarning: Bool = false
    @State private var showingDeletion: Bool = false
    
    @State private var isShowingMapLocation: Bool = false
    
    @State private var cameraPosition: MapCameraPosition
    
    init(friend: Friend) {
        self.friend = friend
        _cameraPosition = State(initialValue: MapCameraPosition.region(
            MKCoordinateRegion(
                center: friend.photoCoordinates, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )
        ))
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(friend.name)
                .font(.title)
                .bold()
                .padding()
            
            ScrollView {
                if let photo: Data = friend.photo, let uiImage: UIImage = UIImage(data: photo) {
                    VStack {
                        Image(uiImage: uiImage)
                            .resizable()
        //                    .frame(maxWidth: .infinity)
        //                    .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 20)
                            .frame(minWidth: UIScreen.main.bounds.width, minHeight: 400)
                            //.border(.red)
                        
                        Toggle("Show Photo Location", isOn: $isShowingMapLocation)
                        if isShowingMapLocation {
                            Map(position: $cameraPosition) {
                                Annotation("Photo Location", coordinate: friend.photoCoordinates) {
                                    Image(systemName: "photo.artframe.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                            .frame(minWidth: UIScreen.main.bounds.width, minHeight: 400)
                        }
                    }
                    
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
        let friend: Friend = Friend(name: "Sam", notes: "Person details", photoLatitude: 29.42, photoLongitude: -98.49)
        return FriendDetailView(friend: friend)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
//    FriendDetailView(friend: Friend(name: "Sam", notes: "Person details"))
}
