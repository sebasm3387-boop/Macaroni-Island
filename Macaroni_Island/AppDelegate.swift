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
        
        guard let screen = NSScreen.main else {
            return
        }
        
        let screenFrame = screen.frame
        let safeArea = screen.safeAreaInsets
        let leftArea = screen.auxiliaryTopLeftArea
        let rightArea = screen.auxiliaryTopRightArea
        
        guard let leftArea = leftArea,
                let rightArea = rightArea else {
            return
        }
        
        let notchWidth = rightArea.minX - leftArea.maxX
        
        
        let islandWidth: CGFloat = notchWidth
        let islandHeight: CGFloat = safeArea.top
        let x = screenFrame.minX + (screenFrame.width - islandWidth) / 2
        let y = screenFrame.maxY - islandHeight
        
        islandPanel = IslandPanel(contentRect: NSRect(x: x, y: y, width: islandWidth, height: islandHeight), styleMask: .borderless, backing: .buffered, defer: false)
        
        let hostingView = NSHostingView(rootView: ContentView()
        )
        
        islandPanel?.contentView =  hostingView
        
        islandPanel?.orderFrontRegardless()
        print("Actual panel frame:", islandPanel?.frame as Any)
        
    }
    }
