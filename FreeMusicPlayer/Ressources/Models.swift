//
//  Models.swift
//  FreeMusicPlayer
//
//  Created by Jeremy Jy on 03/10/2018.
//  Copyright © 2018 Side. All rights reserved.
//

import Foundation

struct StoreItems: Codable {
    let resultCount: Int
    let results: [StoreItem]
}

struct StoreItem: Codable {
    var name: String
    var artist: String
    var description: String
    var kind: String
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind = "kind"
        case description = "description"
        case artworkURL = "artworkUrl100"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: CodingKeys.name)
        self.artist = try values.decode(String.self, forKey: CodingKeys.artist)
        self.kind = try values.decode(String.self, forKey: CodingKeys.kind)
        self.artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            self.description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}
