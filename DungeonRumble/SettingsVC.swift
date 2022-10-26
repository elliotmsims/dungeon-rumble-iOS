//
//  SettingsVCViewController.swift
//  DungeonRumble
//
//  Created by Elliot Sims on 10/11/22.
//

import UIKit

// class for Settings screen
class SettingsVC: UIViewController {
    
    @IBOutlet weak var musicSettingLabel: UILabel!
    
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var difficultySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicSettingLabel.text = "turn off music"
    }
    
    // turn on/off music when switch changes
    @IBAction func musicSwitchChanged(_ sender: Any) {
        if musicSwitch.isOn {
            // restart music player
            musicSystem.playAudio()
            musicSettingLabel.text = "turn off music"
        } else {
            // turn off music
            musicSystem.stopAudio()
            musicSettingLabel.text = "turn on music"
        }
    }
    
    // turn on/off hard mode when switch changes
    @IBAction func difficultySwitchChanged(_ sender: Any) {
        // TODO: implement switch to hard mode for final release
    }
    
    // when "Delete Account" button is pressed, possibly delete user's account
    @IBAction func deleteAccountButtonPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Delete Account",
                                           message: "Are you sure want to delete your account? This will permanently erase your account.",
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        controller.addAction(UIAlertAction(title: "Delete", style: .destructive) {
            // TODO: implement account deletion for beta once firebase backend is set up and also segue to Authentication screen
            action in return
        })
        present(controller, animated: true)
    }
}
