//
//  CustomNavigationController.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//

import Foundation

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpStyle()
    }
    
    private func setUpStyle() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
}
