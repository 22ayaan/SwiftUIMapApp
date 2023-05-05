//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Ayaan Rushil Siddiqui on 2/13/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }// current Location on map
    
    // current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    
    
    // show list of locations
    @Published var showLocationsList: Bool = false
    
    //show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first! // explicitly unwraps the first element in locations array. dont do it if u arent sure whether locations array might possible be empty
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates,
                                           span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        //get the current index in locations array
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("could not find this index in locations array! should never happen")
            return
        }
        
        // or
        // guard let currentIndex = locations.firstIndex { location in
        //      return location == mapLocation
        // }
        
        // check if currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next Index is not valid and so we restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}

