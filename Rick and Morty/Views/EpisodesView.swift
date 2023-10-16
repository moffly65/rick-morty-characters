//
//  EpisodesView.swift
//  Rick and Morty
//
//  Created by Jose Maria Toro on 4/10/23.
//

import SwiftUI

struct EpisodesView: View {
    @ObservedObject var episodeViewModel = EpisodeViewModel()
    @ObservedObject var characterViewModel = CharacterViewModel()
    
    var body: some View {
        if episodeViewModel.isLoading || characterViewModel.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    self.episodeViewModel.loadEpisodes()
                    self.characterViewModel.loadCharacters()
                }
        } else if let error = episodeViewModel.error {
            Text("Error: \(error.localizedDescription)")
        } else {
            
            List(episodeViewModel.episodes) { episode in
                NavigationLink(destination: EpisodeDetailView(episode:episode)) {
                    HStack {
                        Text(episode.name)
                            .bold()
                        Spacer()
                        Text(episode.air_date)
                    }
                    .foregroundColor(Color.white)
                }
                .listRowBackground(Color(red: 0.2, green: 0.2, blue: 0.2))
                .listRowSeparatorTint(Color.white)

            }
            .navigationBarTitle("Episodes", displayMode: .inline)
        }
        
        VStack {
            HStack {
                Button(action: {
                    episodeViewModel.previousPage()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.blue)
                }
                .disabled(episodeViewModel.currentPage == 1)
                
                Spacer()
                
                Text("Page \(episodeViewModel.currentPage)/\(episodeViewModel.totalPages)")
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Button(action: {
                    episodeViewModel.nextPage()
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .padding()
                        .foregroundColor(.blue)
                }
                .disabled(episodeViewModel.currentPage == episodeViewModel.totalPages)
            }
        }
        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        .cornerRadius(30.0)
        .padding()
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
