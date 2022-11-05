//
//  BaseScrollView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/20.
//

import UIKit

class BaseScrollView<Model>: UIScrollView {
    
    // MARK: - Properties
    
    var model: Model? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Functions

extension BaseScrollView {
    
    func configure() {}
    func bind(_ model: Model) {}
    
}
