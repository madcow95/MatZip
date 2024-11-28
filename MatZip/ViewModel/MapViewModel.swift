//
//  MapViewModel.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import Foundation
import CoreLocation
import Combine

class MapViewModel: NSObject {
    private let locationService: LocationService
    var movedCurrentLocation: AnyPublisher<CLLocation?, Never> {
        return locationService.movingCurrentLocation
    }
    
    init(locationService: LocationService) {
        self.locationService = locationService
        super.init()
        
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
