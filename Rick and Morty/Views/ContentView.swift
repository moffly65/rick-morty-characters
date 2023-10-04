//
//  ContentView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading: Bool = false
    @ObservedObject var characterViewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            List(characterViewModel.characters ) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    HStack {
                        URLImageView(url: character.image)
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                            .overlay(Circle().stroke(Color.black,lineWidth: 1))
                        Text(character.name)
                        Spacer()
                        Text(character.species)
                    }
                }
            }
            .navigationBarTitle("Rick and Morty Characters")
        }
        .onAppear {
            self.characterViewModel.loadCharacters()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
