//
//  File.swift
//  
//
//  Created by Daniel Hadzajlic on 27/1/2024.
//

import Foundation
import Raylib

class Cell {
    var xIndex: Int = 0
    var yIndex: Int = 0
    
    var value: Int = 1
    
    var surfaceNormals: [Vector2] = []
    
    func AddSurfaceNormals(normals: [Vector2]) -> Void {
        surfaceNormals.append(contentsOf: normals)
    }
    func ClearSurfaceNormals() -> Void {
        surfaceNormals.removeAll()
    }
    func DrawSurfaceNormals(gridSpacing: Float) -> Void {
        
        if value == 0 {
            return
        }
        
        for x in 0..<surfaceNormals.count {
            var squarePosition = Vector2(x: Float(xIndex) * gridSpacing, y: Float(yIndex) * gridSpacing)
            var endPosition = Vector2(x: Float(surfaceNormals[x].x * gridSpacing/2) + Float(Int32(squarePosition.x)),
                                      y: Float(surfaceNormals[x].y * gridSpacing/2) + Float(Int32(squarePosition.y)))
            var color = Color.red
            if surfaceNormals[x].x == 1 && surfaceNormals[x].y == 0
            {
                color = .green
                squarePosition = Vector2(x: (Float(xIndex) * gridSpacing) + gridSpacing, y: (Float(yIndex) * gridSpacing) + gridSpacing/2)
                
                endPosition = Vector2(x: Float(surfaceNormals[x].x * gridSpacing/2) + Float(Int32(squarePosition.x)),
                                      y: Float(surfaceNormals[x].y * gridSpacing/2) + Float(Int32(squarePosition.y)))
            }
            if surfaceNormals[x].x == -1 && surfaceNormals[x].y == 0
            {
                color = .green
                squarePosition = Vector2(x: (Float(xIndex) * gridSpacing), y: (Float(yIndex) * gridSpacing) + gridSpacing/2)
                
                endPosition = Vector2(x: Float(surfaceNormals[x].x * gridSpacing/2) + Float(Int32(squarePosition.x)),
                                      y: Float(surfaceNormals[x].y * gridSpacing/2) + Float(Int32(squarePosition.y)))
            }
            if surfaceNormals[x].x == 0 && surfaceNormals[x].y == 1
            {
                color = .green
                squarePosition = Vector2(x: (Float(xIndex) * gridSpacing) + gridSpacing/2, y: (Float(yIndex) * gridSpacing) + gridSpacing)
                
                endPosition = Vector2(x: Float(surfaceNormals[x].x * gridSpacing/2) + Float(Int32(squarePosition.x)),
                                      y: Float(surfaceNormals[x].y * gridSpacing/2) + Float(Int32(squarePosition.y)))
            }
            if surfaceNormals[x].x == 0 && surfaceNormals[x].y == -1
            {
                color = .green
                squarePosition = Vector2(x: (Float(xIndex) * gridSpacing) - gridSpacing/2 + gridSpacing, y: (Float(yIndex) * gridSpacing))
                
                endPosition = Vector2(x: Float(surfaceNormals[x].x * gridSpacing/2) + Float(Int32(squarePosition.x)),
                                      y: Float(surfaceNormals[x].y * gridSpacing/2) + Float(Int32(squarePosition.y)))
            }
            
            color = .red
            
            Raylib.drawLine(Int32(squarePosition.x),
                            Int32(squarePosition.y),
                            Int32(endPosition.x),
                            Int32(endPosition.y),
                            color)
        }
    }
    func Draw(gridSpacing: Float, color: Color) -> Void {
        Raylib.drawRectangle(Int32(xIndex) * Int32(gridSpacing), Int32(yIndex) * Int32(gridSpacing), Int32(gridSpacing), Int32(gridSpacing), color)
    }
}
