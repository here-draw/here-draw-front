//
//  PassThroughView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/08.
//

import UIKit

// BottomSheet의 맨 아래 뷰에 사용
class PassThroughView: BaseView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        // superview가 터치 이벤트를 받을 수 있도록,
        // 해당 뷰(subview)가 터치되면 nil 반환, 다른 뷰일 경우 UIView 반환
        return hitView == self ? nil: hitView
    }
}
