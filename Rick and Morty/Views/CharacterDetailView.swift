//
//  CharacterDetailView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI
import Foundation

struct FancyGreyCard: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
            .cornerRadius(10)
            .padding(20)
    }
}

struct CharacterDetailView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    
    let character: Character
    
    var body: some View {
        ZStack {
            FancyGreyCard()
            VStack {
                Spacer()
                Spacer()
                URLImageView(url: character.image)
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                Text(character.name)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                Text(character.species)
                    .font(.title2)
                    .foregroundColor(Color.white)
                
                VStack(alignment: .leading) {
                    HStack {
                        if character.status == "Alive" {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.green)
                        } else if character.status == "Dead" {
                            Image(systemName: "heart.slash.fill")
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.yellow)
                        }
                        Text(character.status )
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Gender:")
                            .foregroundColor(.gray)
                        Text(character.gender )
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Last known location:")
                            .foregroundColor(.gray)
                        if let location = self.locationViewModel.location {
                            NavigationLink(destination: LocationDetailView(location:location)) {
                                if let name = character.location["name"] {
                                    Text(name)
                                        .foregroundColor(.blue)
                                }
                            }}
                    }
                    
                    Spacer()
                    
                    if let createdDate = Utils.dateFormatter.date(from: character.created) {
                        HStack {
                            Text("Created:")
                                .foregroundColor(.gray)
                            Text(Utils.formattedDate(createdDate))
                                .foregroundColor(.white)
                        }
                        
                    } else {
                        Text("Incorrect date")
                    }
                    Spacer()
                }
                .padding(10)
                .foregroundColor(Color.white)
            }
            .padding(20)
        }
        .onAppear {
            if let url = character.location["url"]  {
                self.locationViewModel.loadLocationFromURL(url: url)
            }
        }
        
    }
}

//struct CharacterDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetailView(character: Character)
//    }
//}

