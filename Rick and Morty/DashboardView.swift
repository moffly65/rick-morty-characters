//
//  DashboardView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 11/10/23.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("appdash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //.frame(height: 400)
                    .cornerRadius(30)
                    .padding()
                //Spacer()
                HStack {
                    NavigationLink(destination: ContentView()) {
                        VStack {
                            Image("characters")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                                .cornerRadius(10)
                            Text("Characters")
                        }
                    }
                    Spacer()
                    NavigationLink(destination: LocationsView()) {
                        VStack {
                            Image("locations")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                                .cornerRadius(10)
                            Text("Locations")
                        }
                    }
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                        VStack {
                            Image("episodes")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                                .cornerRadius(10)
                            Text("Episodes")
                        }
                    }
                }
                .padding()
                .navigationBarTitle("Rick & Morty Show")
            }
        }
        
    }
    
    struct DashboardView_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView()
        }
    }
}
