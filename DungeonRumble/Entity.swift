//
//  Entity.swift
//  DungeonRumble
//
//  Created by user228237 on 10/17/22.
//

import Foundation

// simple movement function
private func alternatingMovement(i: Int) -> (String, String)
{
    let type = "move"
    if (i % 2) == 1
    {
        return (type, "N")
    }
    return (type, "S")
}

// invalid move
private func invalid() -> (String, String)
{
    assert(false, "invalid movement")
    return ("", "")
}

// a class to handle entities who may be alive need to be updated every step
// TODO: make abstract?
class Entity
{
    // identifier of the entity, should be unique where identicality matters
    var name : String
    // what type of entity
    var type : String
    // the textual representation of the object
    var repr : Character
    // it's absolute x position in the gameworld, raster-scan order
    var x : Int
    // absolute y position in the gameworld, raster-scan order
    var y : Int
    // bool vare that indicates if the entity has acted this step
    var acted : Bool
    // variable tracking score
    var score : Int
    
    init(name: String, type: String, x: Int, y: Int)
    {
        self.name = name
        self.type = type
        self.x = x
        self.y = y
        self.repr = Self.getRepr(type:type)
        self.acted = false
        self.score = 0
    }
    
    // calculates the repr for the entity
    private static func getRepr(type: String) -> Character
    {
        switch type
        {
        case "player":
            return "@"
        case "wall":
            return "#"
        case "air":
            return "."
        case "spider":
            return "s"
        default:
            assert(false, "Invalid type!")
        }
    }
    
    // gets the action for the given entity
    // TODO: call subclass instead lol
    func getAction() -> (String, String)
    {
        switch self.type
        {
        case "spider":
            return alternatingMovement(i: self.y)
        default:
            assert(false, "Unimplemented error")
        }
    }
        
}
