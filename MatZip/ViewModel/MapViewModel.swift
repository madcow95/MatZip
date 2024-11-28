//
//  MapViewModel.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import Foundation
import CoreLocation

class MapViewModel: NSObject, CLLocationManagerDelegate {
    private let locationService: LocationService
    
    init(locationService: LocationService) {
        self.locationService = locationService
        super.init()
        locationService.getLocationManager().delegate = self
    }
    
    func requestLocationAuth(completion: @escaping (Bool) -> Void) {
        locationService.requestLocationAuth { result in
            completion(result)
        }
    }
}
