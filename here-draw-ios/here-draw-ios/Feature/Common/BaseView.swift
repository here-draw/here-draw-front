//
//  BaseView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/03.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLayout() {}
}
