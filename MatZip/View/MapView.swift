//
//  MapView.swift
//  MatZip
//
//  Created by MadCow on 2024/12/12.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    @StateObject private var mapViewModel = MapViewModel(/*locationService: LocationService()*/)
    @State private var cancellables = Set<AnyCancellable>()
    @State private var camera: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    @State private var searchText: String = ""
    private let categories: [String] = ["한식", "일식", "양식", "중식", "디저트", "카페", "인기", "최신", "아몰라"]
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $camera) {
                Marker("내 위치", coordinate: mapViewModel.currentLocation.coordinate)
                    .tint(.green)
            }
            .mapStyle(.standard)
            .mapControls {
                MapUserLocationButton()
                    .buttonBorderShape(.circle)
                    .controlSize(.regular)
                    .tint(.green)
            }
            
            VStack {
                TextField("검색어를 입력하세요", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .padding(.top, -6)
                    .padding(.trailing, 40)
                    .shadow(radius: 5)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(category) {
                                
                            }
                            .frame(height: 30)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .tint(.orange)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            mapViewModel.$currentLocation
                .dropFirst()
                .sink { location in
                    self.camera = .region(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    )
                }
                .store(in: &cancellables)
        }
    }
}

#Preview {
    MapView()
}
