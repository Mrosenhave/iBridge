//
//  updateNowPlaying.swift
//  iBridge
//
//  Created by Markus Rosenhave on 19/02/2026.
//

import Foundation
import MediaPlayer

func updateNowPlaying(title: String, artist: String, album: String, duration: Double?) {
  var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
    nowPlayingInfo[MPMediaItemPropertyTitle] = title
    nowPlayingInfo[MPMediaItemPropertyArtist] = artist
    nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = album
  if let duration {
    let durationInSeconds = duration / 1000.0
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = durationInSeconds
  }
    
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
}
