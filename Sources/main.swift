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
    
    var mousePosXSnapped = Int32(floor((mousePosition.x/Float(gridSpacing))) * gridSpacing)
    var mousePosYSnapped = Int32(floor((mousePosition.y/Float(gridSpacing))) * gridSpacing)
    
    Raylib.drawRectangle(mousePosXSnapped,
                         mousePosYSnapped,
                         Int32(gridSpacing), Int32(gridSpacing),
                         .darkBlue)
    
    var magnifiedOccupiedCells: [Cell] = [];
    var magnifiedUnoccupiedCells: [Cell] = [];
    
    magnifiedOccupiedCells.removeAll()
    magnifiedUnoccupiedCells.removeAll()
    for x in 0..<4 {
        for y in 0..<4 {
            
            if calculatedIndex + Int32(x) >= worldSize {
                continue;
            }
            if calculatedIndexJ + Int32(y) >= worldSize {
                continue;
            }
            if calculatedIndex - Int32(x) < 0 {
                continue;
            }
            if calculatedIndexJ - Int32(y) < 0 {
                continue;
            }
            
            if world[Int(calculatedIndex) + x][Int(calculatedIndexJ) + y].value == 0 {
                magnifiedUnoccupiedCells.append(world[Int(calculatedIndex) + x][Int(calculatedIndexJ) + y]);
            } else {
                magnifiedOccupiedCells.append(world[Int(calculatedIndex) + x][Int(calculatedIndexJ) + y]);
            }
        }
    }
    
    var averageOccupiedPosition: Vector2 = Vector2(x: 1,y: 1)
    var averageUnoccupiedPosition: Vector2 = Vector2(x: 1, y: 1)
    var sumOfXCoords: Float = 0
    var sumOfYCoords: Float = 0
    var sumOfUnoccupiedXCoords: Float = 0
    var sumOfUnoccupiedYCoords: Float = 0
    /*for x in 0..<magnifiedOccupiedCells.count {
        sumOfXCoords += Float(magnifiedOccupiedCells[x].xIndex)
        sumOfYCoords += Float(magnifiedOccupiedCells[x].yIndex)
    }
    for x in 0..<magnifiedUnoccupiedCells.count {
        sumOfXCoords += Float(magnifiedUnoccupiedCells[x].xIndex)
        sumOfYCoords += Float(magnifiedUnoccupiedCells[x].yIndex)
    }
    averageOccupiedPosition.x = magnifiedOccupiedCells.count == 0 ?
                                                                0 :
                                                                sumOfXCoords/Float(magnifiedOccupiedCells.count) * gridSpacing
    averageOccupiedPosition.y = magnifiedOccupiedCells.count == 0 ?
                                                                0 :
                                                                sumOfYCoords/Float(magnifiedOccupiedCells.count) * gridSpacing
    
    
    averageUnoccupiedPosition.x = magnifiedUnoccupiedCells.count == 0 ?
                                                                    0 :
                                                                    sumOfUnoccupiedXCoords/Float(magnifiedUnoccupiedCells.count) * gridSpacing
    averageUnoccupiedPosition.y = magnifiedUnoccupiedCells.count == 0 ?
                                                                    0 :
                                                                    sumOfUnoccupiedYCoords/Float(magnifiedUnoccupiedCells.count) * gridSpacing
    
    var occupiedToUnoccupied = averageUnoccupiedPosition - averageOccupiedPosition*/
    
    for x in 0..<magnifiedUnoccupiedCells.count {
        averageUnoccupiedPosition.x += Float(magnifiedUnoccupiedCells[x].xIndex) * gridSpacing
        averageUnoccupiedPosition.y += Float(magnifiedUnoccupiedCells[x].yIndex) * gridSpacing
    }
    for x in 0..<magnifiedOccupiedCells.count {
        averageOccupiedPosition.x += Float(magnifiedOccupiedCells[x].xIndex) * gridSpacing
        averageOccupiedPosition.y += Float(magnifiedOccupiedCells[x].yIndex) * gridSpacing
    }
    
    averageUnoccupiedPosition.x = magnifiedUnoccupiedCells.count > 0 ? averageUnoccupiedPosition.x / Float(magnifiedUnoccupiedCells.count) : 0
    averageUnoccupiedPosition.y = magnifiedUnoccupiedCells.count > 0 ? averageUnoccupiedPosition.y / Float(magnifiedUnoccupiedCells.count) : 0
    
    averageOccupiedPosition.x = magnifiedOccupiedCells.count > 0 ? averageOccupiedPosition.x / Float(magnifiedOccupiedCells.count) : 0
    averageOccupiedPosition.y = magnifiedOccupiedCells.count > 0 ? averageOccupiedPosition.y / Float(magnifiedOccupiedCells.count) : 0
    
    
    if averageOccupiedPosition.x != 0 &&
        averageOccupiedPosition.y != 0 &&
        averageUnoccupiedPosition.x != 0 &&
        averageUnoccupiedPosition.y != 0 {
        Raylib.drawLine(Int32(averageOccupiedPosition.x), Int32(averageOccupiedPosition.y), Int32(averageUnoccupiedPosition.x), Int32(averageUnoccupiedPosition.y), .green)
    }
    
    Raylib.drawText("Num of magnified occupied cells: \(magnifiedOccupiedCells.count)", 5, 30, 15, .green)
    Raylib.drawText("Num of magnified unoccupied cells: \(magnifiedUnoccupiedCells.count)", 5, 45, 15, .green)
    Raylib.drawText("Average occupied position: \(averageOccupiedPosition.x), \(averageOccupiedPosition.y)", 5, 60, 15, .green)
    Raylib.drawText("Average unoccupied position: \(averageUnoccupiedPosition.x), \(averageUnoccupiedPosition.y)", 5, 75, 15, .green)
    
    if(magnifiedUnoccupiedCells.count > 0){
        Raylib.drawText("Position of first unoccupied cell: \(magnifiedUnoccupiedCells[0].xIndex), \(magnifiedUnoccupiedCells[0].yIndex)", 5, 90, 15, .green)
        Raylib.drawText("World position of first unoccupied cell: \(Float(magnifiedUnoccupiedCells[0].xIndex) * gridSpacing), \(Float(magnifiedUnoccupiedCells[0].yIndex) * gridSpacing)", 5, 105, 15, .green)
    }
    
    
    Raylib.drawRectangleLines(mousePosXSnapped, mousePosYSnapped, Int32(gridSpacing) * 4, Int32(gridSpacing) * 4, .red)
    
    Raylib.drawCircle(Int32(sumOfXCoords), Int32(sumOfYCoords), 5, .orange)
    
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
