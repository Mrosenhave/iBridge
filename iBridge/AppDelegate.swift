//
//  AppDelegate.swift
//  iBridge
//
//  Created by Markus Rosenhave on 19/02/2026.
//

import AppKit
import MediaPlayer

class AppDelegate: NSObject, NSApplicationDelegate {
  let commandCenter = MPRemoteCommandCenter.shared()
  let infoCenter = MPNowPlayingInfoCenter.default()
  
  private var statusItem: NSStatusItem!
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    DistributedNotificationCenter.default().addObserver(
      self,
      selector: #selector(handleiTunesNotification),
      name: NSNotification.Name("com.apple.iTunes.playerInfo"),
      object: nil
    )
    
    setupRemoteCommands(commandCenter: commandCenter)
    fetchInitialiTunesState()
    
    
    statusItem = NSStatusBar.system.statusItem(
      withLength: NSStatusItem.variableLength
    )
    if let button = statusItem.button {
      button.image = NSImage(
        systemSymbolName: "playpause.circle.fill",
        accessibilityDescription: "iBridge"
      )
    }
    setupMenus()
  }
  
  func setupMenus() {
    let menu = NSMenu()
    
    let imageCell = NSMenuItem()

    let containerView = NSView(frame: NSRect(x: 0, y: 0, width: 180, height: 100))

    let imageView = NSImageView()
    imageView.image = NSImage(named: "AppIcon")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(imageView)

    NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        imageView.widthAnchor.constraint(equalToConstant: 100),
        imageView.heightAnchor.constraint(equalToConstant: 100)
    ])

    imageCell.view = containerView
    menu.addItem(imageCell)
    
    let titleCell = NSMenuItem()
    titleCell.title = "iBridge"
    menu.addItem(titleCell)
    
    let linkCell = NSMenuItem(title: "View on GitHub", action: #selector(openGithubLink), keyEquivalent: "")
    linkCell.target = self // 'self' is the class with the openGithubLink function
    menu.addItem(linkCell)
    
    menu.addItem(NSMenuItem.separator())
    
    menu.addItem(
      NSMenuItem(
        title: "Quit",
        action: #selector(NSApplication.terminate(_:)),
        keyEquivalent: "q"
      )
    )
    
    statusItem.menu = menu
  }
  
  @objc func openGithubLink() {
      if let url = URL(string: "https://www.github.com/Mrosenhave/iBridge") {
          NSWorkspace.shared.open(url)
      }
  }
  
}
