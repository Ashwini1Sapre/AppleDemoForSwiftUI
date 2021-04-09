//
//  ImageLoader.swift
//  AppleDemoForSwiftUI
//
//  Created by Knoxpo MacBook Pro on 09/04/21.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published public private(set) var image: Image?
    
    private var dataTask: URLSessionDataTask?
    private let keyPrefix = "artwork-"
    
    deinit {
        
        dataTask?.cancel()
        
    }
    
    func loadImage(forSong song: Song) {
        
        if let cacheImage = ImageCache.shared.getValue(forKey: "\(keyPrefix)\(song.id)") {
            DispatchQueue.main.async {
                self.image = Image(uiImage: cacheImage)
                return
            }
            
            
        }
        guard let imageURl = URL(string: song.artworkUrl) else { return }
        dataTask = URLSession.shared.dataTask(with: imageURl) { data, _, _ in
            guard let data = data else { return }
            guard let remoteImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: remoteImage)
                ImageCache.shared.setValue(remoteImage, forKey: "\(self.keyPrefix)\(song.id)")
            }
        }
    dataTask?.resume()
  }
    
}
