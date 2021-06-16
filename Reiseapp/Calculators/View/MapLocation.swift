//
//  MapLocation.swift
//  Reiseapp
//
//  Created by FMA1 on 16.06.21.
//

import SwiftUI
import CoreLocation

struct MapLocation: View {
    @StateObject var mapData = MapViewModel()
    // Loction Manager
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack{
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            VStack{
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                        TextField("Suche", text: $mapData.searchTxt)
                            .colorScheme(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding()
                    
                    if !mapData.places.isEmpty && mapData.searchTxt != ""{
                        ScrollView{
                            VStack(spacing: 15){
                                ForEach(mapData.places){ place in
                                    Text(place.placemark.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture{
                                            mapData.selectPlace(place: place)
                                        }
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .background(Color.white)
                    }
                }
                .padding()
                Spacer()
                VStack{
                    Button(action: mapData.focusLocation, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }.navigationBarTitle("Karte", displayMode: .inline)
        .onAppear(perform: {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Zugriff verweigert"), message: Text("Bitte erlauben Sie den Zugriff in Ihren Einstellungen"), dismissButton: .default(Text("Zu den Einstellungen"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: { value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                if value == mapData.searchTxt{
                    self.mapData.searchQuery()
                }
            }
        })
    }
}

struct MapLocation_Previews: PreviewProvider {
    static var previews: some View {
        MapLocation()
    }
}
