//
//  Friend.swift
//  ConferenceFriends
//
//  Created by SCOTT CROWDER on 1/23/24.
//

import Foundation
import SwiftData
import MapKit

@Model
final class Friend {
    var name: String
    var notes: String
    var dateAdded: Date
    var photoLatitude: Double
    var photoLongitude: Double
    @Attribute(.externalStorage) var photo: Data?
    
    var dateFormatted: String {
        dateAdded.formatted(date: .long, time: .standard)
    }
    
    var photoCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: photoLatitude, longitude: photoLongitude)
    }
    
    init(name: String, notes: String, photo: Data? = nil, photoLatitude: Double, photoLongitude: Double) {
        self.name = name
        self.notes = notes
        self.dateAdded = Date()
        self.photo = photo
        self.photoLatitude = photoLatitude
        self.photoLongitude = photoLongitude
    }
    
//    #if DEBUG
//    //static let example: Location = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
//    static let example: Friend = Friend(name: "Sample", notes: "This is an example person.")
//    #endif
}
