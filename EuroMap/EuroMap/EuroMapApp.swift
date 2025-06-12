//
//  EuroMapApp.swift
//  EuroMap
//
//  Created by Ramsés Abdala on 11/2/22.
//

import SwiftUI

@main
struct EuroMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}

// > We want to place our LocationsViewModel within the Environment, so we are going to initialize it within our EuroMap app file, and then pull it out of the Environment whenever we need to use it.
// Then, we are going to pass in our ViewModel to our LocationView.
// Anything that is in our LocationView or a child of our LocationView will have access to our instance of LocationsViewModel which is vm.

// - Goals -
// > The Location Preview cards tutorial does a great job at implementing UI components.

// Body sections should be short and neat.
// The main body for our application is going to be short and organized.

// > Note that our Create instructions are not in order, but a lot of logic was implemented within our LocationsViewModel.

// - Create ViewModel -

// 1. Create a new Group called ViewModels.
// 2. Within the ViewModels Group we are going to create a Swift file called LocationsViewModel.

// - Creat View -

// 1. Create a new Group called Views.
// 2. Within the Views Group we are going to create a SwiftUI View called LocationView.
// 3. Within the Views Group we are going to create a SwiftUI View called LocationsListView.
// 4. Within the Views Group we are going to create a SwiftUI View called LocationPreviewView.
// 5. Within the Views Group we are going to create a SwiftUI View called LocationMapAnnotationView.
// 6. Within the Views Group we are going to create a SwiftUI View called LocationDetailView.

// - Create Models -
// > We are going to create Models for our locations.

// 1. Create a new Group called Models.
// 2. Within the Models group create a Swift file called Location.

// - DataServices -

// 1. Create a new Group called DataServices.
// 2. Within this Group we are going to drag the LocationDataService file that we downloaded from the instructor's website.

// - Summary -
