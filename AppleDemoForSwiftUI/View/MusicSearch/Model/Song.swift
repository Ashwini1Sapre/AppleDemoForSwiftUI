//
//  Song.swift
//  AppleDemoForSwiftUI
//
//  Created by Knoxpo MacBook Pro on 09/04/21.
//

import Foundation
import UIKit

struct SongResponse: Decodable {
    var songs: [Song]
    enum CodingKeys: String,CodingKey {
        case songs = "results"
    }
}

struct Song: Decodable, Identifiable {
        let id: Int
        let trackName: String
        let artistName: String
        let artworkUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id = "trackId"
            case trackName
            case artistName
            case artworkUrl = "artworkUrl60"
        }
    
}
    
    

