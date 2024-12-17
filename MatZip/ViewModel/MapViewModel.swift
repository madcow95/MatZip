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
}
