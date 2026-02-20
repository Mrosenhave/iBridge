//
//  fetchInitialiTunesState.swift
//  iBridge
//
//  Created by Markus Rosenhave on 20/02/2026.
//

import Foundation
import MediaPlayer
import AppKit

func fetchInitialiTunesState() {
  let source = """
    tell application "iTunes"
        if player state is playing or player state is paused then
            return {name of current track, artist of current track, album of current track, duration of current track, player position, player state, get raw data of artwork 1 of current track}
        else
            return {"Stopped", "", ""}
        end if
    end tell
    """
  
  if let descriptor = runAppleScript(code: source) {
    print(descriptor)
    
    if descriptor.numberOfItems >= 7 {
      let title = descriptor.atIndex(1)?.stringValue ?? "Unknown"
      let artist = descriptor.atIndex(2)?.stringValue ?? "Unknown"
      let album = descriptor.atIndex(3)?.stringValue ?? "Unknown"
      let duration = descriptor.atIndex(4)?.doubleValue ?? 0.0
      let position = descriptor.atIndex(5)?.doubleValue ?? 0.0
      let playerState = descriptor.atIndex(6)?.stringValue ?? ""
      let imageData = descriptor.atIndex(7)
      
      
      MPNowPlayingInfoCenter.default().playbackState = playerState == "kPSP" ? .playing : playerState == "kPSp" ? .paused : .stopped
      updateNowPlaying(title: title, artist: artist, album: album, duration: duration*1000)
      var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
      nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = position
      MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
      
      if let imageData, let image = NSImage(data: imageData.data) {
        let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in
          return image
        }
        
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
        nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
      }
      
    }
  }
}
