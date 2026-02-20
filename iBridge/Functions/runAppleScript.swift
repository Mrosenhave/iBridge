//
//  runAppleScript.swift
//  iBridge
//
//  Created by Markus Rosenhave on 19/02/2026.
//

import Foundation

func runAppleScript(code: String) -> NSAppleEventDescriptor? {
  let script = NSAppleScript(source: code)!
  var error: NSDictionary? = nil
  let resultMaybe = script.executeAndReturnError(&error) as NSAppleEventDescriptor?
  guard let result = resultMaybe else {
    print(error as Any)
    return nil
  }
  return result
}
