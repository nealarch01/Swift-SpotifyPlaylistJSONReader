// Swift program that reads spotify playlist from a JSON
// Note: this does not read all objects, just the ones that are necessary to me

import Foundation

struct Playlist: Decodable {
    let description: String 
    let name: String 
    let id: String
    let owner: OwnerData
    let images: Array<ImageData>
    let tracks: Tracks // Does not work
}

struct Tracks: Decodable {
    let items: Array<Item>
}

struct Item: Decodable {
    let track: Track
}

struct Track: Decodable {
    let album: Album
}

struct Album: Decodable {
    let artists: Array<Artist>
    let images: Array<ImageData>
}

struct Artist: Decodable {
    let id: String
    let name: String
}

struct OwnerData: Decodable {
    let display_name: String
}

struct ImageData: Decodable {
    let url: String
}

func initPlaylistData(resource: String) -> Playlist? {
    var playlist: Playlist
    
    let filePath = Bundle.main.path(forResource: resource, ofType: ".json")
    let urlPath = URL(fileURLWithPath: filePath!)
    
    do {
        let jsonData = try Data(contentsOf: urlPath)
        playlist = try JSONDecoder().decode(Playlist.self, from: jsonData)
        
    } catch {
        print ("An error occured trying to read .json file")
        return nil
    }
    
    return playlist
}

let p = initPlaylistData(resource: "tapioca") 
if (p == nil) {
    print("nil")
} else {
    print(p!) // Safely unwrap value
}
