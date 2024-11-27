//
//  LocationService.swift
//  MatZip
//
//  Created by MadCow on 2024/11/27.
//

import CoreLocation
import Combine

class LocationService: NSObject, LocationManager {
    private let locationManager = CLLocationManager()
    private let locationSubject = CurrentValueSubject<CLLocation?, Never>(nil)
    var locationAuthStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    var currentLocation: AnyPublisher<CLLocation?, Never> {
        locationSubject.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuth() {
        
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
}
