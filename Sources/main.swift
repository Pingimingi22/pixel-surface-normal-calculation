// The Swift Programming Language
// https://docs.swift.org/swift-book

import Raylib
import Foundation

let screenWidth: Int32 = 800
    let screenHeight: Int32 = 450

    Raylib.initWindow(screenWidth, screenHeight, "Averaged surface normals")
    Raylib.setTargetFPS(60)
    while Raylib.windowShouldClose == false {
        // update
        
        // draw
        Raylib.beginDrawing()
        Raylib.clearBackground(.rayWhite)
        Raylib.drawFPS(10, 10)
        Raylib.endDrawing()
    }
    Raylib.closeWindow()
