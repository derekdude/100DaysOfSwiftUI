//
//  MainMapView.swift
//  BucketList
//
//  Created by Derek Santolo on 4/8/21.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
            .edgesIgnoringSafeArea(.all)
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
        
        VStack
        {
            Spacer()
            HStack
            {
                Spacer()
                Button(action: {
                    let newLocation = CodableMKPointAnnotation()
                    newLocation.title = "Example Location"
                    newLocation.coordinate = self.centerCoordinate
                    self.locations.append(newLocation)
                    
                    self.selectedPlace = newLocation
                    self.showingEditScreen = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
    }
}

/*struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}*/
