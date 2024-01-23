//
//  Friend.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import SwiftUI

struct Friend {
    var name: String
    var notes: String
    var image: Image?
    
    #if DEBUG
    //static let example: Location = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
    static let example: Friend = Friend(name: "Sample", notes: "This is an example person.", image: Image(systemName: "face.smiling"))
    #endif
}
