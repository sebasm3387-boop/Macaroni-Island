//
//  AppDelegate.swift
//  Macaroni_Island
//
//  Created by Ren Morales on 9/23/26.
//

import AppKit
import SwiftUI


class AppDelegate:
    NSObject, NSApplicationDelegate {
    
    var islandPanel: IslandPanel?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        print("DELEGATE LAUNCHED")
        
        islandPanel = IslandPanel(contentRect: NSRect(x: 0, y: 0, width: 220, height: 40), styleMask: .borderless, backing: .buffered, defer: false)
        
        let hostingView = NSHostingView(rootView: ContentView()
        )
        
        islandPanel?.contentView =  hostingView
        
        islandPanel?.orderFrontRegardless()
        
    }
    }
