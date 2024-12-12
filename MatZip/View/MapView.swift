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
    @State private var searchText: String = ""
    private let categories: [String] = ["한식", "일식", "양식", "중식", "디저트", "카페", "인기", "최신", "아몰라"]
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $camera) {
                
            }
            
            VStack {
                TextField("검색어를 입력하세요", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
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
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    MapView()
}
