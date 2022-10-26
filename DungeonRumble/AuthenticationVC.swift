//
//  ViewController.swift
//  DungeonRumble
//
//  Created by Elliot Sims on 10/8/22.
//

import UIKit

// class for Authentication Choice screen
class AuthenticationVC: UIViewController {

    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // underline "forgot password?"
        forgotPasswordButton.setAttributedTitle(NSAttributedString(string: "forgot password?", attributes: [.underlineStyle : NSUnderlineStyle.single.rawValue, .font : UIFont.boldSystemFont(ofSize: 25.0)]), for: .normal)
    }
    
    // TODO: implement firebase auto-login in beta
}
