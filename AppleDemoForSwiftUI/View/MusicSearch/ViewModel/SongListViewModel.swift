//
//  SongListViewModel.swift
//  AppleDemoForSwiftUI
//
//  Created by Knoxpo MacBook Pro on 09/04/21.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    @Published var artistSearch: String = ""
    @Published public private(set) var songs: [Song] = []
    
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $artistSearch
            .sink(receiveValue: longSongs(forArtist:))
            .store(in: &disposables)
    }
    
    private func longSongs(forArtist artist: String) {
        
        guard  let url = buildUrl(forArtist: artist)  else {
        
            return
        }
        print("Print url \(url)")
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            if let songResponse = try?JSONDecoder().decode(SongResponse.self, from: data) {
                
                DispatchQueue.main.async {
                    self.songs = songResponse.songs
                }
                
            }
            
            
            
            
        }.resume()
        
    }
    
    private func buildUrl(forArtist artist: String) -> URL? {
        
        guard !artist.isEmpty  else {
            return nil
        }
        let queryItems = [
        URLQueryItem(name: "term", value: artist),
            URLQueryItem(name: "entity", value: "song")
        
        ]
        var urlCamps = URLComponents(string: "https://itunes.apple.com/search")
        urlCamps?.queryItems = queryItems
        
        return urlCamps?.url
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
