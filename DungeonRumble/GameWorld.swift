//
//  GameWorld.swift
//  DungeonRumble
//
//  Created by user228237 on 10/17/22.
//

import Foundation
import GameplayKit

// a class that abstracts the tile-based world of the game
class GameWorld
{
    // 2d array of tiles
    var map = [[Entity]]()
    // list of alive entities
    var aliveEntities = [Entity]()
    // width and height of map
    var width : Int
    var height : Int
    // player entity
    let p : Entity
    
    
    // initialize variables
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        // populate world with air
        for y in 0..<height
        {
            map.append([])
            for x in 0..<width
            {
                map[y].append(Entity(name:" ", type:"air", x:x, y:y))
            }
        }
        // add our player character
        self.p = Entity(name: "John", type: "player", x:150, y:150)
        self.aliveEntities.append(p)
        self.map[p.y][p.x] = p
        
        // generate terrain, spawn enemies
        populate()
        spawn()
    }
    
    func populate()
    {
        // use perlin noise for dungeon generation
        let noiseGen = GKPerlinNoiseSource()
        // relative smoothness of perlin noise
        noiseGen.persistence = 0.9
        noiseGen.seed = Int32.random(in: 0..<99999)
        let noise = GKNoise(noiseGen)
        // sample from it
        let sample = GKNoiseMap(noise, size: vector2(1.0, 1.0), origin: vector_double2(0.0, 0.0), sampleCount: vector_int2(Int32(width), Int32(height)), seamless: true)
        for y in 0..<height
        {
            for x in 0..<width
            {
                let loc = vector_int2(Int32(y), Int32(x))
                let height = sample.value(at: loc)
                let blocks_player = (p.y == y || p.x == x)
                // if the perlin noise is low at a given point, make it a wall
                if height < 0.0 && !blocks_player
                {
                    map[y][x] = Entity(name: " ", type: "wall", x:x, y:y)
                }
            }
        }
    }
    
    // function that spawns random enemies
    func spawn()
    {
        // use random dice for spider spawning
        let dice = GKRandomDistribution.init(forDieWithSideCount: 80)
        for y in 0..<height
        {
            for x in 0..<width
            {
                //if we roll a crit fail and the tile is air, spawn a spider
                if dice.nextInt() == 1 && map[y][x].repr == "."
                {
                    let spider = Entity(name: " ", type: "spider", x:x, y:y)
                    self.aliveEntities.append(spider)
                    map[y][x] = spider
                }
            }
        }
    }
    
    
    // given x,y, let 0,0 be the top left of the screen
    // return tiles to make the character centered
    func tileAtDelta(x: Int, y: Int) -> Character
    {
        return map[p.y - (20 / 2) + y][p.x - (78 / 2) + x].repr
    }
    
    // makes all entities able to act this turn
    func unact()
    {
        for e in self.aliveEntities
        {
            e.acted = false
        }
    }
    
    // takes a step, updating the entire map and triggering all AI
    // this assumes the player has already acted
    func step()
    {
        for e in self.aliveEntities
        {
            if e.acted
            {
                continue
            }
            
            let action = e.getAction()
            let type = action.0
            let dir = action.1
            switch (type)
            {
            case "move":
                moveEntity(e: e, dir: dir)
                e.acted = true
            default:
                assert(false, "Not implemented type")
            }
        }
        
        unact()
    }
    
    // directional string to 2d coord delta
    func dirToDelta(dir: String) -> (x: Int, y: Int)
    {
        var dx = 0
        var dy = 0
        switch dir
        {
        case "N":
            dy = -1
        case "S":
            dy = 1
        case "E":
            dx = 1
        case "W":
            dx = -1
        default:
            dx = -1
            dy = -1
            assert(false, "Invalid Direction")
        }
        
        return (dx, dy)
    }
    
    // TODO: make unified abstraction of player action to avoid bugs
    
    // makes the player attack in a given dir
    func attackPlayer(dir: String)
    {
        self.attack(e: p, dir: dir)
        p.acted = true
        // update AI
        step()
    }
    
    // lets an entity attack something
    func attack(e: Entity, dir: String)
    {
        assert(e === p, "Only the player can attack currently")
        
        let delta = dirToDelta(dir: dir)
        let dx: Int = delta.x
        let dy: Int = delta.y
        
        // TODO: bounds check?
        let enemy = map[e.y + dy][e.x + dx]
        // hardcoded for now
        if enemy.type == "spider"
        {
            let idx = aliveEntities.firstIndex{$0 === enemy}!
            aliveEntities.remove(at: idx)
            map[e.y + dy][e.x + dx] = Entity(name: " ", type: "air", x: e.x + dx, y: e.y + dy)
            p.score += 1
        }
        
    }
    
    // lets the player move in a given direction
    func movePlayer(dir: String)
    {
        self.moveEntity(e: p, dir: dir)
        p.acted = true
        // update enemy ai
        step()
    }
    
    // lets an entity move if possible
    func moveEntity(e: Entity, dir: String)
    {
        let delta = dirToDelta(dir: dir)
        let dx: Int = delta.x
        let dy: Int = delta.y
        
        
        let inbounds = (e.y + dy >= 0 && e.y + dy < self.height) && (e.x + dx >= 0 && e.x + dx < self.height)
        // move our entity e
        if inbounds && map[e.y + dy][e.x + dx].repr == "."
        {
            map[e.y][e.x] = Entity(name: " ", type: "air", x:e.x, y:e.y)
            e.x += dx
            e.y += dy
            map[e.y][e.x] = e
        }
    }
}
