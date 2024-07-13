//
//  GetStarred.swift
//  HalpoPlayer
//
//  Created by Theo Selpin on 13.07.24.
//

import Foundation

// using /getStarred2
struct GetStarredResponse: Codable {
    let subsonicResponse: SubsonicResponse

    enum CodingKeys: String, CodingKey {
        case subsonicResponse = "subsonic-response"
    }

    struct SubsonicResponse: Codable {
        let status, serverVersion, type: String
        let starred2: Starred
        let version: String
    }
}

struct Starred: Codable {
    //let albums: [GetAlbumResponse]
    //let artists: [GetArtistResponse]
    let songs: [Song]

    enum CodingKeys: String, CodingKey {
        //case artists = "artist"
        //case albums = "album"
        case songs = "song"
    }
}
