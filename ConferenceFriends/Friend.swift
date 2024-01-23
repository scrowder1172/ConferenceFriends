//
//  Friend.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import Foundation
import SwiftData

@Model
final class Friend {
    var name: String
    var notes: String
    var dateAdded: Date
    
    var dateFormatted: String {
        dateAdded.formatted(date: .long, time: .standard)
    }
    
    init(name: String, notes: String) {
        self.name = name
        self.notes = notes
        self.dateAdded = Date()
    }
    
//    #if DEBUG
//    //static let example: Location = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
//    static let example: Friend = Friend(name: "Sample", notes: "This is an example person.")
//    #endif
}
