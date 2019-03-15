//
//  AppDelegate.swift
//  Sock
//
//  Created by Matt Lorentz on 3/12/19.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func newTab(_ sender: NSMenuItem) {
        guard let window = NSApplication.shared.mainWindow else {
            return
        }
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let newTab: NSWindowController =
            storyboard.instantiateController(withIdentifier: "Window") as? NSWindowController else {
            return
        }
        
        window.addTabbedWindow(newTab.window!, ordered: .above)
    }

}

