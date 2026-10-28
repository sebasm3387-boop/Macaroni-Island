//
//  AppDelegate.swift
//  Macaroni_Island
//
//  Created by Ren Morales on 9/23/26.
//

import AppKit
import SwiftUI
import QuartzCore


class AppDelegate:
    NSObject, NSApplicationDelegate {
    
    var islandPanel: IslandPanel?
    var localMouseMonitor: Any?
    var globalMouseMonitor: Any?
    var isHovering = false
    
    var notchWidth: CGFloat = 0
    var notchHeight: CGFloat = 0
    
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
        
        notchWidth = rightArea.minX - leftArea.maxX
        notchHeight = safeArea.top
        
        
        let islandWidth: CGFloat = notchWidth
        let islandHeight: CGFloat = notchHeight
        let x = screenFrame.minX + (screenFrame.width - islandWidth) / 2
        let y = screenFrame.maxY - islandHeight
        
        islandPanel = IslandPanel(contentRect: NSRect(x: x, y: y, width: islandWidth, height: islandHeight), styleMask: .borderless, backing: .buffered, defer: false)
        
        let hostingView = NSHostingView(rootView: ContentView()
        )
        
        islandPanel?.contentView =  hostingView
        
        islandPanel?.orderFrontRegardless()
        startMouseTracking()
        
        print("Actual panel frame:", islandPanel?.frame as Any)
        
    }
    
    func startMouseTracking() {
        
        localMouseMonitor = NSEvent.addLocalMonitorForEvents( matching: [.mouseMoved]
        ) { [weak self] event in
            
            self?.checkMousePosition()
            
            return event
        }
        
        globalMouseMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved]
        ) { [weak self] _ in
            
            DispatchQueue.main.async {
                self?.checkMousePosition()
            }
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        
        if let localMouseMonitor {
            NSEvent.removeMonitor(localMouseMonitor)
        }
        
        if let globalMouseMonitor {
            NSEvent.removeMonitor(globalMouseMonitor)
        }
    }
    
    func checkMousePosition() {
        guard let panel = islandPanel else { return }
        
        let mouseLocation = NSEvent.mouseLocation
        let frame = panel.frame
        
        let hoverArea = NSRect(
            x: frame.minX - 20,
            y: frame.minY - 10,
            width: frame.width + 40,
            height: frame.height + 20
            )
        
        let hovering = hoverArea.contains(mouseLocation)
        
        if hovering != isHovering {
            isHovering = hovering
            
            resizeIsland(hovering: hovering)
            
            print(hovering ? "Mouse entered island1" : "Mouse left island!")
            
            print("Panel visible", panel.isVisible)
            print("Panel on active Space:", panel.isOnActiveSpace)
        }
    }
    
    func resizeIsland(hovering: Bool) {
        guard let panel = islandPanel,
              let screen = panel.screen ?? NSScreen.main else{
            return
        }
        
        let newWidth = notchWidth + (hovering ? 30 : 0)
        let newHeight = notchHeight + (hovering ? 8 : 0)
        
        let screenFrame = screen.frame
        
        let newX = screenFrame.midX - newWidth / 2
        let newY = screenFrame.maxY - newHeight
        
        let newFrame = NSRect(
            x: newX,
            y: newY,
            width: newWidth,
            height: newHeight
            )
        
        NSAnimationContext.runAnimationGroup { context in context.duration = hovering ? 0.25 : 0.20
            context.timingFunction = CAMediaTimingFunction(
                name: .easeInEaseOut
            )
            
            panel.animator().setFrame(newFrame, display: true)
        }
    }
    }
