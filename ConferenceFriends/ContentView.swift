//
//  ContentView.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    
    let sampleFriends: [Friend] = [
        Friend(name: "John", notes: "Met at a bar", image: Image(systemName: "face.smiling")),
        Friend(name: "Tammy", notes: "Real Estate Conference", image: Image(systemName: "face.smiling")),
        Friend(name: "Larry", notes: "Florida Golf Course", image: Image(systemName: "face.smiling")),
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sampleFriends, id: \.name) { sample in
                    
                    NavigationLink {
                        VStack(alignment: .leading) {
                            HStack {
                                sample.image
                                Text(sample.name)
                            }
                            Text(sample.notes)
                                .font(.caption)
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                sample.image
                                Text(sample.name)
                            }
                            Text(sample.notes)
                                .font(.caption)
                        }
                    }
                    
                }
                
                
            }
            .navigationTitle("Conference Friends")
        }
    }
}

#Preview {
    ContentView()
}
