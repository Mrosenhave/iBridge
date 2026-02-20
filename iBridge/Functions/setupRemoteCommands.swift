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
    runAppleScript(code: "tell application \"iTunes\" to playpause")
    return .success
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
    runAppleScript(code: "tell application \"iTunes\" to previous track")
    MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
    return .success
  }
  
}
