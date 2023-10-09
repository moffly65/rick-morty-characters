//
//  ContentView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var characterViewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            if characterViewModel.isLoading {
                ProgressView("Cargando...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        self.characterViewModel.loadCharacters()
                    }
            } else if let error = characterViewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                List(characterViewModel.characters) { character in
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
                }
                .navigationBarTitle("Rick and Morty Characters", displayMode: .inline)
                .foregroundColor(Color.white)
            }
        }
        
        VStack {
            HStack {
                Button(action: {
                    characterViewModel.previousPage()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.blue)
                }
                .disabled(characterViewModel.currentPage == 1)
                
                Spacer()
                
                Text("Página \(characterViewModel.currentPage)/\(characterViewModel.totalPages)")
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Button(action: {
                    characterViewModel.nextPage()
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.blue)
                }
                .disabled(characterViewModel.currentPage == characterViewModel.totalPages)
            }
        }
        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        .cornerRadius(30.0)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
