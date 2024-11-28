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
    private var authResult: ((Bool) -> Void)?
    
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
    
    func getLocationManager() -> CLLocationManager {
        return self.locationManager
    }
    
    func requestLocationAuth(completion: @escaping (Bool) -> Void) {
        authResult = completion
        
        switch self.locationAuthStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .denied, .restricted, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            completion(false)
        @unknown default:
            completion(false)
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            authResult?(true)
        case .denied, .restricted:
            authResult?(false)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            authResult?(false)
        }
    }
}
