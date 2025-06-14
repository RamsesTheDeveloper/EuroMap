//
//  LocationDetailView.swift
//  EuroMap
//
//  Created by Ramsés Abdala on 11/2/22.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    // @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(
                        color: Color.black.opacity(0.3),
                        radius: 20,
                        x: 0,
                        y: 10
                    )
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailView {
 
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
                // .frame() + .clipped() remove a weird glitch that occurs when we are swiping through images.
                // Note that this works for the iPhone, but not the iPad
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia.", destination: url)
                    .font(.headline)
                    .tint(Color.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01))),
            annotationItems: [location],
            annotationContent: { location in
                MapAnnotation(
                    coordinate: location.coordinates) {
                        LocationMapAnnotationView()
                            .shadow(radius: 10)

                    }
            }
        )
        .allowsHitTesting(false) // Disables gestures on map, won't allow users to interact with the map.
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button {
            // dismiss()
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
}
