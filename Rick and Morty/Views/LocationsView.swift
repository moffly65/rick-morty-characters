//
//  LocationsView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    @ObservedObject var characterViewModel = CharacterViewModel()
    
    var body: some View {
        if locationViewModel.isLoading || characterViewModel.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    self.locationViewModel.loadLocations()
                    self.characterViewModel.loadCharacters()
                }
        } else if let error = locationViewModel.error {
            Text("Error: \(error.localizedDescription)")
        } else {
            
            List(locationViewModel.locations) { location in
                NavigationLink(destination: LocationDetailView(location:location)) {
                    HStack {
                        Text(location.name)
                            .bold()
                        Spacer()
                        Text(location.type)
                    }
                    .foregroundColor(Color.white)
                }
                .listRowBackground(Color(red: 0.2, green: 0.2, blue: 0.2))
                .listRowSeparatorTint(Color.white)
            }
            .navigationBarTitle("Locations", displayMode: .inline)
            .foregroundColor(Color.white)
        }
        
        VStack {
            HStack {
                Button(action: {
                    locationViewModel.previousPage()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.blue)
                }
                .disabled(locationViewModel.currentPage == 1)
                
                Spacer()
                
                Text("Página \(locationViewModel.currentPage)/\(locationViewModel.totalPages)")
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Button(action: {
                    locationViewModel.nextPage()
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.blue)
                }
                .disabled(locationViewModel.currentPage == locationViewModel.totalPages)
            }
        }
        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        .cornerRadius(30.0)
        .padding()
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
