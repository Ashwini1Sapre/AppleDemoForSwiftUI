//
//  MusicMainView.swift
//  AppleDemoForSwiftUI
//
//  Created by Knoxpo MacBook Pro on 09/04/21.
//

import SwiftUI
import Combine
import UIKit
struct MusicMainView: View {
    
    @State private var searchTerm: String = ""
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        NavigationView {
            
            VStack {
                SearchBar(searchTerm: $viewModel.artistSearch)
                if viewModel.songs.isEmpty {
                    ZeroStateView()
                    
                }
                else {
                    
                    List(viewModel.songs) { song in
                        SongView(song: song)
                        
                        
                    }.listStyle(PlainListStyle())
                }
                
                
            }.navigationBarTitle("Music Search")
            
           
        }
       
    }
}

struct ZeroStateView: View {
    var body: some View {
        VStack {
            
          Spacer()
            Image(systemName: "music.note")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start Searching Music....")
                .font(.title)
          Spacer()
        }
        
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
    
}
struct SongView: View {
    public let song: Song
    @StateObject private var imageLoader: ImageLoader = ImageLoader()
    var body: some View {
        
        HStack {
            
            ArtworkView(image: imageLoader.image)
                .padding(.trailing)
            VStack(alignment: .leading) {
                
                Text(song.trackName)
                Text(song.artistName)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
            
        }
        .onAppear {
            
            imageLoader.loadImage(forSong: song)
        }
        
        .padding()
    }
    
    
    
    
}


struct ArtworkView: View {
    let image: Image?
    
    var body: some View
    {
        ZStack {
            if image != nil{
                
                image
            } else {
                Color(.systemIndigo)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
        }
        .frame(width: 50, height: 50)
        .shadow(radius: 5)
        .padding(.trailing, 5)
        
        
    }
    
}



struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Here"
        return searchBar
    }
    
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
    
    func makeCoordinator() -> searchBarCoordinator{
        return searchBarCoordinator(searchTerm: $searchTerm)
    }
    
    
    
    class searchBarCoordinator: NSObject, UISearchBarDelegate {
        
        @Binding var searchTerm: String
        
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first {
                $0.isKeyWindow }?.endEditing(true)
            }
        }
        
        
        
        
        
    }
    
    
    
    










struct MusicMainView_Previews: PreviewProvider {
    static var previews: some View {
        MusicMainView(viewModel: SongListViewModel())
    }
}
