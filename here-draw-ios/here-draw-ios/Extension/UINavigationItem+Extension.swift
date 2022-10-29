//
//  UINavigationItem+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/26.
//

import UIKit

extension UINavigationItem {
    func setTitleView(style: titleStyle = .default) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: DeviceUtils.statusBarHeight, width: DeviceUtils.width, height: DeviceUtils.navigationBarHeight)).then {
            $0.text = style.text
            $0.font = style.font
            $0.textColor = style.color
        }
        
        switch style.pos {
        case .left:
            self.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        case .right:
            return
        case .center:
            self.titleView = titleLabel
        }
    }
    
    func setBarButton(pos: PosType, styles: buttonStyle...) {
        var barButtonItems = [UIBarButtonItem]()
        
        for style in styles {
            let button = UIButton().then {
                $0.setImage(style.image, for: .normal)
                $0.tintColor = style.color
                if let action = style.action {
                    $0.addTarget(self, action: action, for: .touchUpInside)
                }
            }
            let barButtonItem = UIBarButtonItem(customView: button).then {
                $0.customView?.snp.makeConstraints {
                    $0.width.height.equalTo(20)
                }
            }
            barButtonItems.append(barButtonItem)
            barButtonItems.append(spacing(20))
        }
        
        switch pos {
        case .left:
            self.leftBarButtonItems = barButtonItems
        case .right:
            self.rightBarButtonItems = barButtonItems
        case .center:
            return
        }
    }
    
    func spacing(_ spacing: CGFloat) -> UIBarButtonItem {
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 20
        return spacer
    }
}

extension UINavigationItem {
    enum PosType {
        case left
        case right
        case center
    }
    
    // titleView 전용 스타일
    struct titleStyle {
        var pos: PosType
        var text: String?
        var font: UIFont?
        var color: UIColor
        
        init(pos: PosType, text: String? = nil, font: UIFont? = nil, color: UIColor) {
            self.pos = pos
            self.text = text
            self.font = font
            self.color = color
        }
        
        static var `default` = titleStyle(
            pos: .center,
            text: "",
            font: .sfPro18Pt2,
            color: .white1
        )
    }
    
    // barButton 전용 스타일
    struct buttonStyle {
        var image: UIImage
        var color: UIColor
        var action: Selector?
        
        static var `default` = buttonStyle(
            image: .init(systemName: "ellipsis")!,
            color: .white1
        )
    }
}
