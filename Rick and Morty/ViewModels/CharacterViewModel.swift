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
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    @Published var currentPage: Int = 1
    let charactersPerPage: Int = 20
    @Published var error: Error? = nil
    @Published var rawResponseData: [String: Any] = [:]
    @Published var totalCount: Int = 0
    @Published var totalPages: Int = 0
    
    func loadCharacters() {
        isLoading = true
        error = nil
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(currentPage)") else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let info = jsonData["info"] as? [String: Any] ?? [:]
                        DispatchQueue.main.async {
                            self.rawResponseData = jsonData
                            self.totalCount = info["count"] as? Int ?? 0
                            self.totalPages = info["pages"] as? Int ?? 0
                        }
                    }
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
                        self.error = error
                    }
                }
            }
        }
        .resume()
    }
    
    func nextPage() {
        currentPage += 1
        loadCharacters()
    }
    
    func previousPage() {
        if currentPage > 1 {
            currentPage -= 1
            loadCharacters()
        }
    }
    
    struct CharacterResponse: Decodable {
        let results: [Character]
    }
}
