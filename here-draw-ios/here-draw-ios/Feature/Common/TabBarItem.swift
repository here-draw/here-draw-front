//
//  TabBarItem.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case message
    case article
    case wish
    case mypage
}

extension TabBarItem {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .message:
            return "메세지"
        case .article:
            return "아티클"
        case .wish:
            return "찜"
        case .mypage:
            return "마이페이지"
        }
    }
}

extension TabBarItem {
    var inactiveIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "tabHome")
        case .message:
            return UIImage(named: "tabMessage")
        case .article:
            return UIImage(named: "article")
        case .wish:
            return UIImage(named: "heart")
        case .mypage:
            return UIImage(named: "tabMypage")
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "tabHomeActive")
        case .message:
            return UIImage(named: "tabMessage")
        case .article:
            return UIImage(named: "article")
        case .wish:
            return UIImage(named: "heartFill")
        case .mypage:
            return UIImage(named: "tabMypageActive")
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: inactiveIcon,
            selectedImage: activeIcon
        )
    }
}


