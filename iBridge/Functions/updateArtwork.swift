//
//  updateArtwork.swift
//  iBridge
//
//  Created by Markus Rosenhave on 20/02/2026.
//

import Foundation
import MediaPlayer
import AppKit

func updateArtwork() {
  let source = "tell application \"iTunes\" to get raw data of artwork 1 of current track"
  
  if let descriptor = runAppleScript(code: source) {
    
    if let image = NSImage(data: descriptor.data) {
      let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in
        return image
      }
      
      var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
      nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
      MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
  }
}
