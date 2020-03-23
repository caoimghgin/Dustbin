//
//  AppDelegate.swift
//  DustBin
//
//  Created by Kevin Muldoon on 3/23/20.
//  Copyright © 2020 Kevin Muldoon. All rights reserved.
//

import Cocoa

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

