//
//  MapView.swift
//  MatZip
//
//  Created by MadCow on 2024/12/12.
//

import SwiftUI
import MapKit

struct MapView: View {
    private let mapViewModel = MapViewModel(locationService: LocationService())
    @State private var camera: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    ))
    
    var body: some View {
        Map(position: $camera) {
            // 여기에 마커나 다른 맵 콘텐츠를 추가할 수 있습니다
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView()
}
