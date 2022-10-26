//
//  LoginVC.swift
//  DungeonRumble
//
//  Created by Elliot Sims on 10/8/22.
//

import UIKit

// class for Login screen
class LoginVC: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.isHidden = true
    }
    
    // TODO: add firebase verification w/ error handling in beta
}
