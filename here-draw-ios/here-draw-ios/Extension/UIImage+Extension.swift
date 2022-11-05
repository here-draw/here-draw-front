//
//  UIImage+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/04.
//

import UIKit

extension UIImage {
    func scaledHeight(scaledWidth: CGFloat) -> CGFloat {
        let oldSize = self.size
        let scaleFactor = scaledWidth / CGFloat(oldSize.width)
        return CGFloat(oldSize.height) * scaleFactor
    }
}
