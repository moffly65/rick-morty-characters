//
//  CharacterViewModel.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import Foundation

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let species: String
    let image: URL
    let status: String
    let gender: String
    let created: String
    let episode: [String]
}

class CharacterViewModel: ObservableObject {
    public var characters: [Character] = []
    @Published var isLoading: Bool = false
    
    func loadCharacters() {
        isLoading = true
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CharacterResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.characters = response.results
                        self.isLoading = false
                    }
                } catch {
                    print("Error decoding data: \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }
        .resume()
    }
    
    struct CharacterResponse: Decodable {
        let results: [Character]
    }
    
}
