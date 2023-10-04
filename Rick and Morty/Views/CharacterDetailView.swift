//
//  CharacterDetailView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            URLImageView(url: character.image)
                .frame(width: 150, height: 150)
                .cornerRadius(75)
                .padding(0)
            //.background(Color.gray).clipShape(Circle())
                .overlay(Circle().stroke(Color.black,lineWidth: 3))
            
            Text(character.name)
                .font(.title)
            Text(character.species)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text("Status: " + character.status + "\n")
                    .alignmentGuide(.leading) { _ in -15 }
                Text("Gender: " + character.gender + "\n")
                    .alignmentGuide(.leading) { _ in -15 }
                Text("Created: " + character.created + "\n")
                    .alignmentGuide(.leading) { _ in -15 }
                
                List {
                    Section(header: Text("Episodes")) { // Add a section header
                        ForEach(character.episode, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
            .padding(10)
            Spacer()
        }
    }
}
