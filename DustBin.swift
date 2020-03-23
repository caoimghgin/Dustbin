//
//  DustBin.swift
//  HelloDialog
//
//  Created by Kevin Muldoon on 3/23/20.
//  Copyright © 2020 Kevin Muldoon. All rights reserved.
//

import Foundation
import Cocoa

class DustBin {
    
    let now: Date
    let yearMonthDay: String
    let hourMinuteSecond: String
    let dateFormatter: DateFormatter
    let fileManager : FileManager
    let desktopDirectory: FileManager.SearchPathDirectory
    let documentDirectory: FileManager.SearchPathDirectory
    let dustBinDirectoryName: String

    init() {
        self.now = Date()
        self.yearMonthDay = "yyyyMMdd"
        self.hourMinuteSecond = "HHmmss"
        self.dateFormatter = DateFormatter()
        self.fileManager = FileManager.default
        self.desktopDirectory = FileManager.SearchPathDirectory.desktopDirectory
        self.documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        self.dustBinDirectoryName = "DustBin"
        
        process()
    }
    
    func process() {
        let contentsOfDesktopDirectory = contentsOfDirectory(getDirectoryURL(self.desktopDirectory))
        print(contentsOfDesktopDirectory)
        if (contentsOfDesktopDirectory.count > 0) {
            let directory = createDustbinDirectory()
            moveFilesToDirectory(contentsOfDesktopDirectory, directory)
            revealDustBinDirectory(directory)
        }
    }
    
    func createDustbinDirectory() -> URL {
        
        let yearMonthDay = dateFormat(self.yearMonthDay)
        let hourMinuteSecond = dateFormat(self.hourMinuteSecond)
        
        let documentDirectory = getDirectoryURL(self.documentDirectory)
        let result = documentDirectory.appendingPathComponent(self.dustBinDirectoryName).appendingPathComponent(yearMonthDay).appendingPathComponent(hourMinuteSecond)
        
        do {
             try self.fileManager.createDirectory(at: result, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Unexpected error: \(error).")
        }
        return result
    }
    
    func moveFilesToDirectory(_ files: [URL],_ directory: URL) {
        for file in files {
            let fileName = file.lastPathComponent
            let newPath = directory.appendingPathComponent(fileName)
            do {
                try self.fileManager.moveItem(at: file, to: newPath)
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    func getDirectoryURL(_ directory: FileManager.SearchPathDirectory) -> URL {
        return self.fileManager.urls(for: directory, in: .userDomainMask).first!
    }
    
    func dateFormat(_ dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self.now)
    }
    
    func contentsOfDirectory(_ url: URL) -> [URL] {
        var result:[URL] = []
        do {
            result = try self.fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options:[.skipsHiddenFiles])
        } catch {
            print("Error while enumerating files \(url.path): \(error.localizedDescription)")
        }
        return result
    }
    
    func revealDustBinDirectory(_ url: URL) {
        NSWorkspace.shared.open(url)

    }
    
    func showNoItemsToMoveAlert() {
        let alert = NSAlert()
        alert.messageText = "No items to move"
        alert.informativeText = "There are no items to move on desktop."
        alert.runModal()
    }
    
}

