//
//  Helpers.swift
//  SmartBoy
//
//  Created by Prasanth pc on 2019-04-19.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

extension CALayer {
    func addBorder(with color: UIColor) {
        self.borderColor = color.cgColor
        self.borderWidth = 2.0
    }
}

extension UIView {
    func addUnderLine() {
        self.layoutIfNeeded()
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: self.bounds.height - 0.5, width: self.bounds.width, height: 0.5)
        layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(layer)
    }
}
