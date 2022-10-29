//
//  NavigationBarView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/29.
//

import UIKit

class NavigationBarView: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.barTintColor = .black1
        self.isTranslucent = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
