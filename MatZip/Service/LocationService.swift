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
    
    func searchPlaceBy(category: String) async throws -> Place? {
        var components = URLComponents(string: "https://openapi.naver.com/v1/search/local.json")
        components?.queryItems = [
            URLQueryItem(name: "query", value: "\(category) 맛집"),
            URLQueryItem(name: "display", value: String(100)),
            URLQueryItem(name: "start", value: String(1)),
            URLQueryItem(name: "sort", value: "random")
        ]
        
        guard let url = components?.url else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid Response", code: -2)
        }
        do {
            return try JSONDecoder().decode(Place.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
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
