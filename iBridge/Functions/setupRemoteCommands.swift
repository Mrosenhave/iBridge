//
//  setupRemoteCommands.swift
//  iBridge
//
//  Created by Markus Rosenhave on 20/02/2026.
//

import Foundation
import MediaPlayer

func setupRemoteCommands(commandCenter: MPRemoteCommandCenter) {
  commandCenter.togglePlayPauseCommand.removeTarget(nil)
  commandCenter.togglePlayPauseCommand.isEnabled = true
  commandCenter.togglePlayPauseCommand.addTarget { _ in
    let result = runAppleScript(code: "tell application \"iTunes\" to playpause")
    return result == nil ? .commandFailed : .success
  }
  
  commandCenter.pauseCommand.removeTarget(nil)
  commandCenter.pauseCommand.isEnabled = true
  commandCenter.pauseCommand.addTarget { _ in
    runAppleScript(code: "tell application \"iTunes\" to pause")
    return .success
  }
  
  commandCenter.playCommand.removeTarget(nil)
  commandCenter.playCommand.isEnabled = true
  commandCenter.playCommand.addTarget { _ in
    runAppleScript(code: "tell application \"iTunes\" to play")
    return .success
  }
  
  commandCenter.nextTrackCommand.removeTarget(nil)
  commandCenter.nextTrackCommand.isEnabled = true
  commandCenter.nextTrackCommand.addTarget { _ in
    runAppleScript(code: "tell application \"iTunes\" to next track")
    MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
    return .success
  }
  
  commandCenter.previousTrackCommand.removeTarget(nil)
  commandCenter.previousTrackCommand.isEnabled = true
  commandCenter.previousTrackCommand.addTarget { _ in
    let source = """
      tell application "iTunes"
          if (player position > 5) then
              set player position to 0
          else
              previous track
          end if
      end tell
      """
    runAppleScript(code: source)
    MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
    return .success
  }
  
  commandCenter.changePlaybackPositionCommand.removeTarget(nil)
  commandCenter.changePlaybackPositionCommand.isEnabled = true
  commandCenter.changePlaybackPositionCommand.addTarget { event in
      guard let positionEvent = event as? MPChangePlaybackPositionCommandEvent else {
          return .commandFailed
      }
      let newTime = positionEvent.positionTime
    
      runAppleScript(code: "tell application \"iTunes\" to set player position to \(newTime)")
      
      return .success
  }
  
}
