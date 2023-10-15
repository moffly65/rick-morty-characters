//
//  LocationDetailView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI
import Foundation

struct LocationDetailView: View {
    @ObservedObject var characterViewModel = CharacterViewModel()
    
    let location: Location
    
    var body: some View {
        ZStack {
            FancyGreyCard()
            VStack {
                Text(location.name)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.top, 40)
                Text(location.type)
                    .font(.title2)
                    .foregroundColor(Color.white)
                VStack(alignment: .leading) {
                    Text("Dimension: " + location.dimension )
                    if let createdDate = Utils.dateFormatter.date(from: location.created) {
                        Text("Created: \(Utils.formattedDate(createdDate))")
                    } else {
                        Text("Incorrect date")
                    }
                }
                .padding(10)
                .foregroundColor(Color.white)
                .onAppear() {
                    self.characterViewModel.loadCharactersFromURLS(strings: location.residents)
                }
                
                List {// }(characterViewModel.characters) { character in
                    Text("Residents: (\(characterViewModel.characters.count))" )
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                    ForEach(characterViewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack {
                                URLImageView(url: character.image)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                    .overlay(Circle().stroke(Color.white,lineWidth: 1))
                                Text(character.name)
                                Spacer()
                                Text(character.species)
                            }
                        }
                        .listRowBackground(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .listRowSeparatorTint(Color.white)
                        .foregroundColor(Color.white)
                    }
                }
                .padding(.top, 0)
                .padding(.leading, 4)
                .padding(.bottom, 10)
                .padding(.trailing, 4)
            }
            .navigationBarTitle("Location", displayMode: .inline)
            .foregroundColor(Color.white)
            
        }
        .padding(.top, 15)
        .padding(.leading, 0)
        .padding(.bottom, 0)
        .padding(.trailing, 0)
    }
}

//struct LocationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationDetailView(location: location
//    }
//}

