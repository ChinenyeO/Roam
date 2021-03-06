//
//  RoundedViews.swift
//  Roam
//
//  Created by Darrel Muonekwu on 8/18/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
    }
}

class RoundedLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

class RoundedView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedImageView : UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

class RoundedProfilePicture: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 4
        layer.borderColor = UIColor.white.cgColor
        
        layer.cornerRadius = 85

    }
}

class BaseTabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        var defaultIndex: Int = 0
        
        func viewDidLoad() {
            super.viewDidLoad()
            selectedIndex = defaultIndex
        }
    }
}

class TranslucentNavBar: UINavigationBar {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundImage(UIImage(), for: .default)
        self.isTranslucent = true        
    }
}

class TranslucentNavController: UINavigationController {
    override func awakeFromNib() {
        super.awakeFromNib()

        self.view.backgroundColor = .clear
        
    }
}
