//
//  updatePlayerPosition.swift
//  iBridge
//
//  Created by Markus Rosenhave on 20/02/2026.
//

import Foundation
import MediaPlayer

func updatePlayerPosition() {
  let source = """
    tell application "iTunes"
        if player state is playing or player state is paused then
            return {player position}
        else
            return {"Stopped", "", ""}
        end if
    end tell
    """
  
  if let descriptor = runAppleScript(code: source) {
    print(descriptor)
    
    if descriptor.numberOfItems >= 1 {
      let position = descriptor.atIndex(1)?.doubleValue ?? 0.0
      var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
      nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = position
      MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
  }
}
