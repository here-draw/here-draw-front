//
//  DeviceUtils.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import Foundation
import UIKit

// 디바이스 관련 크기 정의
final class DeviceUtils {
    
    // window
    static let window: UIWindow = {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first ?? UIWindow()
    }()
    
    // 디바이스 width
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // 디바이스 height
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // 상태바 height
    static var statusBarHeight: CGFloat {
        return  window.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    // 네비게이션 바 height
    static var navigationBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }
    
    static public func calculateImageHeight(sourceImage: AnyObject, scaledToWidth: CGFloat) -> CGFloat {
        let oldWidth = CGFloat(sourceImage.width)
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = CGFloat(sourceImage.height) * scaleFactor
        return newHeight
    }
}
