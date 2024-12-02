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
    
    func searchPlace() async throws {
        var components = URLComponents(string: "https://openapi.naver.com/v1/search/local.json")
        components?.queryItems = [
            URLQueryItem(name: "query", value: "한식"),
            URLQueryItem(name: "display", value: String(100)),
            URLQueryItem(name: "start", value: String(1)),
            URLQueryItem(name: "sort", value: "random")
        ]
        
        guard let url = components?.url else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        
        // URLRequest 구성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        // API 호출
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid Response", code: -2)
        }
        print(httpResponse.statusCode)
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        }
        let resData = try JSONDecoder().decode(Place.self, from: data)
        print(resData.places)
    }
}
