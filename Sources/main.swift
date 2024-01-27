// The Swift Programming Language
// https://docs.swift.org/swift-book

import Raylib
import Foundation
import CoreGraphics

let screenWidth: Int32 = 850
let screenHeight: Int32 = 650

let gridSpacing: Float = 20;

var world: [[Cell]] = []

let worldSize = 30

Raylib.initWindow(screenWidth, screenHeight, "Averaged surface normals")
Raylib.setTargetFPS(60)

for index in 0...worldSize-1 {
    world.append([Cell]())
    for indexJ in 0...worldSize-1 {
        var color = Color.red;
        
        var newCell = Cell();
        newCell.xIndex = index
        newCell.yIndex = indexJ
        
        print("Creating cell: \(index), \(indexJ)")
        world[index].append(newCell)
    }
}

while Raylib.windowShouldClose == false {
    // update
    
    
    let mousePosition = Raylib.getMousePosition();
    let calculatedIndex = Int32(floor((mousePosition.x/gridSpacing)));
    let calculatedIndexJ = Int32(floor((mousePosition.y/gridSpacing)))
    
    if Raylib.isMouseButtonPressed(MouseButton.left) {
        if calculatedIndex < world.count
            && calculatedIndex >= 0
            && calculatedIndexJ < world.count
            && calculatedIndexJ >= 0 {
            
            world[Int(calculatedIndex)][Int(calculatedIndexJ)].value = 0;
            print("Pressed coordinate: \(calculatedIndex), \(calculatedIndexJ)")
            print("Coordinate according to cell: \(world[Int(calculatedIndex)][Int(calculatedIndexJ)].xIndex), \(world[Int(calculatedIndex)][Int(calculatedIndexJ)].yIndex)")
            print("Mouse coordinates: \(mousePosition.x), \(mousePosition.y)")
            
        }
    }
    if Raylib.isMouseButtonPressed(MouseButton.right) {
        if calculatedIndex < world.count
            && calculatedIndex >= 0
            && calculatedIndexJ < world.count
            && calculatedIndexJ >= 0 {
            
            world[Int(calculatedIndex)][Int(calculatedIndexJ)].value = 1;
            print("Pressed coordinate: \(calculatedIndex), \(calculatedIndexJ)")
            print("Mouse coordinates: \(mousePosition.x), \(mousePosition.y)")
            
        }
    }
    
    if Raylib.isKeyPressed(KeyboardKey.leftBracket) {
        for index in 0...world.count-1 {
            for indexJ in 0...world[index].count-1 {
                world[index][indexJ].ClearSurfaceNormals()
                world[index][indexJ].AddSurfaceNormals(normals: GetSurfaceNormals(x: Int32(index), y: Int32(indexJ)))
            }
        }
    }
    
    for x in 0...world.count-1 {
        for y in 0...world[x].count-1 {
            
            var color = Color.magenta
            
            if world[x][y].value == 0 {
                color = .rayWhite
            }
            else
            {
                color = .black
            }
            world[x][y].Draw(gridSpacing: gridSpacing, color: color)
        }
    }
    
    for x in 0...world.count-1 {
        for y in 0...world[x].count-1 {
            world[x][y].DrawSurfaceNormals(gridSpacing: gridSpacing)
        }
    }
    Raylib.drawRectangle(Int32(floor((mousePosition.x/Float(gridSpacing))) * gridSpacing),
                         Int32(floor((mousePosition.y/Float(gridSpacing))) * gridSpacing),
                         Int32(gridSpacing), Int32(gridSpacing),
                         .darkBlue)
    
    // draw
    Raylib.beginDrawing()
    Raylib.clearBackground(.rayWhite)
    Raylib.drawFPS(10, 10)
    Raylib.endDrawing()
}
Raylib.closeWindow()


func GetSurfaceNormals(x: Int32, y: Int32) -> [Vector2] {
    var surfaceNormals: [Vector2] = []
    
    if x-1 > 0 {
        if world[Int(x-1)][Int(y)].value == 0 {
            surfaceNormals.append(Vector2(x: -1, y: 0))
        }
    }
    
    if x+1 < world.count {
        if world[Int(x+1)][Int(y)].value == 0 {
            surfaceNormals.append(Vector2(x: 1, y: 0))
        }
    }
    
    if y+1 < world.count {
        if world[Int(x)][Int(y+1)].value == 0 {
            surfaceNormals.append(Vector2(x: 0, y: 1))
        }
    }
    
    if y-1 > 0 {
        if world[Int(x)][Int(y-1)].value == 0 {
            surfaceNormals.append(Vector2(x: 0, y: -1))
        }
    }
    
    return surfaceNormals;
}
