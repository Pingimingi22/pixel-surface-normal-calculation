//
//  Rectangle.swift
//
//
//  Created by Daniel Hadzajlic on 8/1/2024.
//

import Foundation
import Raylib

class Rectangle {
    var position: Vector2 = Vector2(x: 0, y: 0)
    var velocity: Vector2 = Vector2(x: 500, y: 0)
    var acceleration: Vector2 = Vector2(x: 0, y: 4000)
    
    var x: Int32 {
        get { return Int32(position.x)}
    }
    var y: Int32 {
        get { return Int32(position.y)}
    }
    
    init(position: Vector2) {
        self.position = position
    }
    
    func Draw() -> Void {
        Raylib.drawRectangle(Int32(position.x), Int32(position.y), 100, 100, .black)
    }
    func Update() -> Void {
        position.x = position.x + velocity.x * Raylib.getFrameTime()
        position.y = position.y + velocity.y * Raylib.getFrameTime()
        velocity.x = velocity.x + acceleration.x * Raylib.getFrameTime()
        velocity.y = velocity.y + acceleration.y * Raylib.getFrameTime()
    }
}
