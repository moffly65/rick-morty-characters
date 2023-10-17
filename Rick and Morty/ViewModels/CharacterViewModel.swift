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
    let location: [String:String]
    let created: String
    let episode: [String]
}

class CharacterViewModel: ObservableObject {
    @Published var character: Character?
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    @Published var searchString: String = ""

    @Published var currentPage: Int = 1
    let charactersPerPage: Int = 20
    @Published var error: Error? = nil
    @Published var rawResponseData: [String: Any] = [:]
    @Published var totalCount: Int = 0
    @Published var totalPages: Int = 0
    
    func loadCharacters() {
        isLoading = true
        error = nil
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(currentPage)&name=\(searchString)") else {
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
    
    func loadCharactersFromURLS(strings:[String]) {
        isLoading = true
        error = nil
        
        for item in strings {
            guard let _ = URL(string: item) else {
                isLoading = false
                return
            }
            self.loadCharacterFromURL(url: item)
        }
    }
    
    func loadCharacterFromURL(url: String) {
        isLoading = true
        error = nil
        
        guard let characterURL = URL(string: url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: characterURL) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.error = error
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Character.self, from: data)
                    self.character = response
                    if let character = self.character {
                        self.characters.append(character)
                    }
                    print(response.name as Any)
                } catch {
                    self.error = error
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
    
    struct SingleCharacterResponse: Decodable {
        let results: Character
    }
}
