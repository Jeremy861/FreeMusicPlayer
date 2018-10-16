//
//  Playlists.swift
//  FreeMusicPlayer
//
//  Created by Jeremy Jy on 04/10/2018.
//  Copyright © 2018 Side. All rights reserved.
//

import Foundation

class Playlists{
    var title: String
    var Songs = [Song]()
    
    init(title: String) {
        self.title = title
    }
    
    func loadSamplePlaylist() -> Void {
        let song1 = Song(title: "Hello", artist: "Michael Jackson", songUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")
        let song2 = Song(title: "I am", artist: "Weeknd", songUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")
        let song3 = Song(title: "me", artist: "Ariana Grande", songUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")
        let song4 = Song(title: "Who", artist: "Beiju", songUrl: "https://www.hrupin.com/wp-content/uploads/mp3/testsong_20_sec.mp3")
        let song5 = Song(title: "is this", artist: "Avicii", songUrl: "https://ia801409.us.archive.org/12/items/1HourThunderstorm/1HrThunderstorm.mp3")
        
        Songs.append(song1)
        Songs.append(song2)
        Songs.append(song3)
        Songs.append(song4)
        Songs.append(song5)
    }
    
    func addMusicToPlaylist(songAdded: Song) -> Void {
        Songs.append(songAdded)
    }
}
