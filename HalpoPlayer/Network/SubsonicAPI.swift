//
//  SubsonicAPI.swift
//  halpoplayer
//
//  Created by paul on 13/07/2023.
//

import Foundation

enum SubsonicAPI {
	case authenticate
	case getAlbumList(page: Int, sort: AlbumSortType = .newest)
	case getAlbum(id: String)
	case randomSongs(albumId: String?)
	case search(term: String)
	case getIndexes
	case coverArt(albumId: String)
	case stream(id: String, mp3: Bool)
	case getSimilarSongs(id: String)
	case getPlaylists
	case getPlaylist(id: String)
	case updatePlaylist(id: String, songs: [Song])
	case addSongsToPlaylist(playlistId: String, songIds: [String])
	case getArtists
	case getArtist(id: String)
	case getArtistInfo(id: String)
	case getStarred
	case createPlaylist(name: String)
	case scrobble(id: String)
	
	var method: String {
		"GET"
	}
	
	var pathComponent: String {
		switch self {
		case .authenticate:
			return "ping.view?"
		case .getAlbumList(let page, let sort):
			let pageSize = 24
			let offset = pageSize * page
			let sortString = sort.rawValue
			return "getAlbumList?type=\(sortString)&size=\(pageSize)&offset=\(offset)"
		case .getAlbum(let id):
			return "getAlbum?id=\(id)"
		case .randomSongs(let albumId):
			if let albumId = albumId {
				return "getRandomSongs?size=500&musicFolderId=\(albumId)"
			} else {
				return "getRandomSongs?size=500"
			}
		case .search(let term):
			return "search2?query=\(term)"
		case .getIndexes:
			return "getIndexes?"
		case .coverArt(let albumId):
			return "getCoverArt?id=\(albumId)&size=500"
		case .stream(let id, let mp3):
			let format = mp3 ? "&format=mp3" : "&format=raw"
			return "stream?id=\(id)\(format)"
		case .getSimilarSongs(let id):
			return "getSimilarSongs?id=\(id)"
		case .getPlaylists:
			return "getPlaylists?"
		case .getPlaylist(let id):
			return "getPlaylist?id=\(id)"
		case .updatePlaylist(let id, let songs):
			var newIds: String = ""
			var removalIndices: String = ""
			for (index, song) in songs.enumerated() {
				newIds.append("&songIdToAdd=\(song.id)")
				removalIndices.append("&songIndexToRemove=\(index)")
			}
			return "updatePlaylist?playlistId=\(id)\(removalIndices)\(newIds)"
		case .addSongsToPlaylist(let playlistId, let songIds):
			var idString = ""
			for id in songIds {
				idString.append("&songIdToAdd=\(id)")
			}
			return "updatePlaylist?playlistId=\(playlistId)\(idString)"
		case .getArtists:
			return "getArtists?"
		case .getArtist(let id):
			return "getArtist?id=\(id)"
		case .getArtistInfo(let id):
			return "getArtistInfo?id=\(id)"
		case .getStarred:
			return "getStarred2?"
		case .createPlaylist(let name):
			return "createPlaylist?name=\(name)"
		case .scrobble(let id):
			return "scrobble?id=\(id)&submission=true"
		}
	}
}
