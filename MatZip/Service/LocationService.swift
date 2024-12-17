//
//  LocationService.swift
//  MatZip
//
//  Created by MadCow on 2024/12/12.
//

import CoreLocation
import Combine

class LocationService: NSObject, LocationManager {
    private let locationManager = CLLocationManager()
    private var authResult: ((Bool) -> Void)?
    @Published var location: CLLocation?
    
    var locationAuthStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationAuth(completion: @escaping (Bool) -> Void) {
        authResult = completion
        
        switch self.locationAuthStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            completion(false)
        }
    }
    
    func getCurrentLocation() {
        locationManager.requestLocation()
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 오류: \(#function)\n\(error.localizedDescription)")
    }
}
