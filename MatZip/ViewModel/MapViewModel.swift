//
//  MapViewModel.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import Foundation
import CoreLocation
import Combine
import SwiftUICore

class MapViewModel: ObservableObject {
    private var locationService = LocationService()
    @Published var currentLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    @Published var places: [PlaceInfo] = []
    
    init() {
        locationService.$location
            .compactMap { $0 }
            .assign(to: &$currentLocation)
    }
    
    func requestLocationAuth(completion: @escaping (Bool) -> Void) {
        locationService.requestLocationAuth { result in
            completion(result)
        }
    }
    
    func updateLocation() {
        locationService.getCurrentLocation()
    }
    
    @MainActor
    func searchPlaceBy(category: String) async {
        places = []
        do {
            guard let place = try await locationService.searchPlaceBy(category: category) else {
                return
            }
            places = place.items
            print(places.count)
             if places.count > 0 {
                 self.currentLocation = CLLocation(latitude: places.first!.coordinate.latitude, longitude: places.first!.coordinate.longitude)
//                 let centerLat = places.map { $0.coordinate.latitude }.reduce(0, +) / Double(places.count)
//                 let centerLng = places.map { $0.coordinate.longitude }.reduce(0, +) / Double(places.count)
//                 self.currentLocation = CLLocation(latitude: centerLat, longitude: centerLng)
             }
        } catch {
            print(error, #function)
        }
    }
}
