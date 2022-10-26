//
//  DeathVC.swift
//  DungeonRumble
//
//  Created by Will Mannel on 10/15/22.
//

import UIKit

// class for Death screen
class DeathVC: UIViewController {

    @IBOutlet weak var deathMessage: UILabel!
    
    // TODO: get current score and add it to firebase in beta
    var score: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deathMessage.text = "you made it to the \(score)th\n floor of the dungeon"
    }
    
    // TODO: replace button in beta with "touch screen" gesture to return to Play Game screen
}
