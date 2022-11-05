//
//  UIButton+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/21.
//

import UIKit

extension UIButton {
    
    func shadow(opacity: Float, color: UIColor, offset: CGSize) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
    }
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }
}
