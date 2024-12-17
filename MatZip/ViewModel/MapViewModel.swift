//
//  MapViewModel.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import Foundation
import CoreLocation
import Combine

class MapViewModel: NSObject, ObservableObject {
    private let locationService: LocationService
    @Published var currentLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    init(locationService: LocationService) {
        self.locationService = locationService
        super.init()
        guard let currentLocation = locationService.location else {
            print("no location")
            return
        }
        self.currentLocation = currentLocation
    }
    
    func requestLocationAuth(completion: @escaping (Bool) -> Void) {
        locationService.requestLocationAuth { result in
            completion(result)
        }
    }
    
    func updateLocation() {
        locationService.getCurrentLocation()
    }
}
