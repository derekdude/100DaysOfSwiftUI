//
//  ContentView.swift
//  BucketList
//
//  Created by Derek Santolo on 3/29/21.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct AuthError: Identifiable {
    var id: String { type }
    var type: String
}

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    @State private var authError: AuthError?
    
    var body: some View {
        ZStack {
            if isUnlocked
            {
                MainMapView(centerCoordinate: $centerCoordinate, locations: $locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, showingEditScreen: $showingEditScreen)
            }
            else
            {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert(item: $authError) { error in
                    Alert(title: Text("Authentication Failed"), message: error.type == "noBiometrics" ? Text("This device has no biometrics.") :
                            Text("FaceID authentication failed."), dismissButton: .default(Text("OK")))
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "MIssing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlace")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        }
        catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        }
        catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                    else {
                        authError = AuthError(type: "nonMatchingFace")
                    }
                }
            }
        }
        
        else {
            authError = AuthError(type: "noBiometrics")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
