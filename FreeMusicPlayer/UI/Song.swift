//
//  Song.swift
//  FreeMusicPlayer
//
//  Created by Jeremy Jy on 04/10/2018.
//  Copyright © 2018 Side. All rights reserved.
//

import Foundation

class Song{
    var title: String
    var artist: String
    var songURL: String
    //var description: String
    //var category: String
    
    init(title: String, artist: String, songUrl: String) {
        self.title = title
        self.artist = artist
        self.songURL = songUrl
    }
}
