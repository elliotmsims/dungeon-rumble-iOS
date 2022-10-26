//
//  BorderView.swift
//  DungeonRumble
//
//  Created by Elliot Sims on 10/11/22.
//

import UIKit

class BorderView: UIView {
    
    // creates dark blue border
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.borderWidth = 10
        self.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.1294117647, blue: 0.2431372549, alpha: 1)
        self.clipsToBounds = true
    }
}
