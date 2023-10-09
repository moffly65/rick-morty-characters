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
            .fill(Color.gray)
            .cornerRadius(10)
            .padding(20)
    }
}

struct CharacterDetailView: View {
    let character: Character
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()

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
                    Text("Gender: " + character.gender )
                    Spacer()
                    if let createdDate = dateFormatter.date(from: character.created) {
                        Text("Created: \(formattedDate(createdDate))")
                    } else {
                        Text("Fecha incorrecta")
                    }
                    Spacer()
                }
                .padding(10)
                .foregroundColor(Color.white)

//                List {
//                    Section(header: Text("Episodes")) {
//                        ForEach(character.episode, id: \.self) { item in
//                            Text(item)
//                        }
//                    }
//                }
            }
            .padding(20)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }

}
