// Swift program that reads spotify playlist from a JSON
// Note: this does not read all objects, just the ones that are necessary to me
// To compile: swiftc main.swift

import Foundation
import Darwin

struct Playlist: Decodable {
    let description: String 
    let name: String 
    let id: String
    let owner: OwnerData
    let images: Array<ImageData>
    let tracks: Tracks 
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

func initPlaylistData(filename: String) -> Playlist? {
    var playlist: Playlist
    
    let filePath = Bundle.main.path(forResource: filename, ofType: ".json")

    if filePath == nil {
        let templateString: String = "%@.json file was not found"
        let message = String(format: templateString, filename)
        print(message)
        return nil
    }

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

print("Enter json filename")
let jsonFilename: String? = readLine()

let result: Playlist? = initPlaylistData(filename: jsonFilename!)

if result != nil {
    print(result!)
    exit(0)
}

exit(2)
