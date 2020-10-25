//
//  AppDelegate.swift
//  Dustbin
//
//  Created by Kevin Muldoon on 10/25/20.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let _ = DustBin()
        exit(0);

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

