//
//  LocationsViewModel.swift
//  EuroMap
//
//  Created by Ramsés Abdala on 11/2/22.
//

import Foundation
import MapKit
import SwiftUI

// All of our data is in sync because our ViewModel is in the Environment.
class LocationsViewModel: ObservableObject {
    
    // All locations.
    @Published var locations: [Location]
    
    // The location shown in the LocationView.
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        } // didSet will set the location automatically.
    }
    
    // Current region on map.
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations.
    @Published var showLocationsList: Bool = false // List won't be displayed when the app starts, only when the header is clicked within the LocationView.
    
    // Show location detail via sheet.
    @Published var sheetLocation: Location? = nil
    
    init() {
        // From our LocationsDataService file we are going to access the locations array that is holding all of our instances of Location model, then we are going to assign it to the locations variable within our init.
        let locations = LocationsDataService.locations
        
        // We are going to assign the locations retrieved from our data service to our Published variable, our Published variable is used to display information in our View.
        self.locations = locations
        
        // We are force unwrapping here because the data that we are retrieving is hardcoded into our application.
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            ) // center is the location on the map
            // span controls if we want to be zoomed in or out to that location, a span of 0.1 is fairly zoomed in.
        }
    }
    
    // Toggles our showLocationsList variable.
    // We are creating a function because we want to use the .easeInOut animation anytime we toggle the list.
    // This function is used within our header, which is inside of our LocationView.
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            // showLocationsList = !showLocationsList
            showLocationsList.toggle()
        }
    } // This is a public function because we are going to use it within our LocationView.
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    // Our function will find the next location within our array of locations so that we can display it when the user clicks on the nextButton.
    func nextButtonPressed() {
        // Get the current index
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        }
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen.")
            return // if we can't get the currentIndex we are going to return
        }
        
        // Check if the nextIndex is valid
        let nextIndex = currentIndex + 1 // We go to the next index by adding 1.
        
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid.
            // Reset the index to 0.
            guard let firstLocation = locations.first else {
                print("Location not found.")
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index is valid, so we are going to set it as the next location.
        let nextLocation = locations[nextIndex] // This could potentially crash our application, but we are checking that there is a value at our next index with our locations.indices.contains(nextIndex) guard statement.
        
        showNextLocation(location: nextLocation)
    }
}
