//
//  IslandPanel.swift
//  Macaroni_Island
//
//  Created by Ren Morales on 9/23/26.
//

import AppKit

class IslandPanel: NSPanel {
    override init(
        contentRect: NSRect,
        styleMask style: NSWindow.StyleMask,
        backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool
    ) {
        super.init(
            contentRect: contentRect,
            styleMask: .borderless,
            backing: backingStoreType,
            defer: flag
        )
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.level = .floating
    }
}
