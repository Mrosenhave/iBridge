//
//  handleiTunesNotification.swift
//  iBridge
//
//  Created by Markus Rosenhave on 20/02/2026.
//

import Foundation
import MediaPlayer

extension AppDelegate {
  @objc func handleiTunesNotification(notification: Notification) {
    if let trackInfo = notification.userInfo as NSDictionary? {
      print("Track Info: \(trackInfo)")
      let playbackState: MPNowPlayingPlaybackState = (trackInfo["Player State"] as? String ?? "") == "Playing" ? .playing : (trackInfo["Player State"] as? String ?? "") == "Paused" ? .paused : .stopped
      MPNowPlayingInfoCenter.default().playbackState = playbackState
      updateNowPlaying(title: trackInfo["Name"] as? String ?? "", artist: trackInfo["Artist"] as? String ?? "", album: trackInfo["Album"] as? String ?? "", duration: trackInfo["Total Time"] as? Double ?? 0.0)
      if playbackState == .stopped {
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPMediaItemPropertyArtwork] = nil
      } else {
        updatePlayerPosition()
        updateArtwork()
      }
    }
  }
}
