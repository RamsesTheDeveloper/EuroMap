//
//  Location.swift
//  EuroMap
//
//  Created by Ramsés Abdala on 11/2/22.
//

import Foundation
import MapKit

// Equatable helps the compiler decide if two locations have the same id.
// We need to conform to Equatable because it is possible that two locations can have the same name and cityName with a different description.
struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    
    // We are referencing the images via their names.
    // We have more than one image so we are going to use an array.
    let imageNames: [String]
    let link: String
    
    // Identifiable
    var id: String {
        name + cityName // id = "ColosseumRome"
    } // > This is a computed property.
    // We are using a computed property because we need an ID in order to conform to Identifiable.
    // We cannot assign a random ID to our Models because it can cause issues where Locations can have the same id.
    // So, we are going to add the name of the location and the cityName to create a unique id.
    
    // In production applications our locations would have an ID given to them by a backend service.
    
    // - Equatable -
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id // If the locations have the same ID then we will return true.
    }
}
