//
//  GameVC.swift
//  DungeonRumble
//
//  Created by user228237 on 10/13/22.
//

import UIKit
import GameplayKit


class GameVC: UIViewController {

    // this connects to a label covering the entire VC -- this is where all
    // info is displayed
    @IBOutlet weak var display: UILabel!
    // this is a 2D array version of the above information
    // displayArr[y][x] is the y-th row, x-th column
    var displayArr = [[Character]]()
    // gameworld which holds our entities and actual map
    var world : GameWorld?
    
    // number of characters high
    let height = 20
    // number of characters wide
    let width = 78
    // if were attacking next step
    var attack = false
    
    var player: Entity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make our display font monospace (IMPORTANT)
        display.font = UIFont(name: "Courier", size: 18)
        // initialize world w/ 500^2 dimensions
        world = GameWorld(width: 500, height: 500)
        
        // setup our map with empty strings
        for y in 0..<height
        {
            displayArr.append([])
            for _ in 0..<width
            {
                displayArr[y].append(" ")
            }
        }
        
        // populate hud
        setupHUD()
        // generate borders around hud
        generateOutline()
        // render the first frame
        render()
    }
    
    // loops a given functor over the displayArr
    func loop(functor: (_ x: Int, _ y: Int, _ z: Character) -> Character)
    {
        for y in 0..<height
        {
            for x in 0..<width
            {
                displayArr[y][x] = functor(x, y, displayArr[y][x])
            }
        }
        
    }
    
    // generates vertical / horizontal borders
    func generateOutline()
    {
        func borders(x: Int, y: Int, z: Character) -> Character
        {
            if [1, width - 2].contains(x)
            {
                return "|"
            }
            if [0, 4, height - 1].contains(y)
            {
                return "-"
            }
            return z
        }
        self.loop(functor: borders)
    }
    
    // sets up the hud
    func setupHUD()
    {
        // TODO: make this actually work
        let l1 = "   STATS HP:99, MP:99, AC:99, LVL:99|ITEM AD:99, MP:99, LVLREQ:99  "
        let l2 = "   ENEMY HP:99, MP:99, AC:99, LVL:99|SWAP AD:99, MP:99, LVLREQ:99  "
        let l3 = "   DESCR \(self.attack ? "You ready your sword" : "You're standing calmly.")        |ENVIR Nothing here yet.. |SCORE: \(self.world!.p.score)"
        let hud = [l1, l2, l3]
        for (i, line) in hud.enumerated()
        {
            var mut_l = line
            if line.count < width
            {
                // verify the line isn't too long or short
                mut_l.append(String(Array(repeating:" ", count:width - mut_l.count)))
            }
            displayArr[i + 1] = Array(mut_l)
            assert(displayArr[i + 1].count == width)
        }
    }

    
    // populates screen with information from world and rerender hud
    func render()
    {
        // within the range of game-world, get tiles from gameworld
        for y in 5..<height - 1
        {
            for x in 2..<width - 2
            {
                displayArr[y][x] = self.world!.tileAtDelta(x: x, y: y)
            }
        }
        
        // last chance to render hud
        setupHUD()
        
        var arr_strings = [String]()
        for y in 0..<height
        {
            // convert char array to strings
            arr_strings.append(String(displayArr[y]))
        }
        // TODO: color strings somewhere around here?
        // convert list of strings to one big one!
        display.text? = arr_strings.joined(separator: "\n")
    }

    // when the attack button is pressed, toggle our attacking status
    @IBAction func activateAttack(_ sender: UIButton) {
        self.attack = !self.attack
        // it modified hud, rerender
        render()
    }
    
    // a directional button is pressed, handle
    @IBAction func movementButton(_ sender: UIButton) {
        let dir: String
        
        // extract which directional button was pressed
        switch sender.tag
        {
        case 0:
            dir = "N"
        case 1:
            dir = "E"
        case 2:
            dir = "S"
        case 3:
            dir = "W"
        default:
            dir = "F"
            assert(false, "Invalid button value")
        }
        
        // if we're not attacking, (currently) we're moving
        if (!attack)
        {
            self.world!.movePlayer(dir: dir)
        }
        // else we're attacking
        else
        {
            self.world!.attackPlayer(dir: dir)
            self.attack = false
        }
        
        // rerender frame after whatever we do is done
        render()
    }
}
