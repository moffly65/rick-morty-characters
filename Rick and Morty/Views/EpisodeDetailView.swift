//
//  EpisodeDetailView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI
import Foundation

struct EpisodeDetailView: View {
    @ObservedObject var characterViewModel = CharacterViewModel()
    
    let episode: Episode
    
    var body: some View {
        ZStack {
            FancyGreyCard()
            VStack {
                Text(episode.name)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.top, 40)
                Text(episode.air_date)
                    .font(.title2)
                    .foregroundColor(Color.white)
                .padding(10)
                .foregroundColor(Color.white)
                .onAppear() {
                    self.characterViewModel.loadCharactersFromURLS(strings: episode.characters)
                }
                
                List {// }(characterViewModel.characters) { character in
                    Text("Characters: (\(characterViewModel.characters.count))" )
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
            .navigationBarTitle("Episode", displayMode: .inline)
            .foregroundColor(Color.white)
            
        }
        .padding(.top, 15)
        .padding(.leading, 0)
        .padding(.bottom, 0)
        .padding(.trailing, 0)
    }
}

//struct EpisodeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//    }
//}

