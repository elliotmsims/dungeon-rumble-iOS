//
//  PlayGameVC.swift
//  DungeonRumble
//
//  Created by Elliot Sims on 10/10/22.
//

import UIKit

// class for the Play Game screen
class PlayGameVC: UIViewController {

    @IBOutlet weak var highestScore: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    
    // TODO: get values from firebase in beta
    let user = "knight3452"
    let userHighestScore = 34
    let userCurrentScore = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highestScore.text = "\(user)'s highest score: \(userHighestScore)"
        currentScore.text = "current score: \(userCurrentScore)"
    }
    
    // TODO: implement Tutorial level in beta
}
