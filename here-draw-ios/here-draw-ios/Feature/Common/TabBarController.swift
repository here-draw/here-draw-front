//
//  TabBarController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Properties
    
    private var tabs: [UIViewController] = []
    private var previousTabIndex: Int = 0

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarAppearance()
        setTabBarItems()
        setDelegation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let imageView = tabBar.subviews[item.tag + 1].subviews.compactMap({ $0 as? UIImageView }).first
        else { return }
        
        tabBarItemBounceAnimation(imageView: imageView)
    }
}

// MARK: - Functions

extension TabBarController {
    private func setTabBarAppearance() {
        UITabBar.appearance().backgroundImage = nil
        UITabBar.appearance().backgroundColor = .mediumBlack
        UITabBar.appearance().tintColor = .pastelYellow
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.sfPro11Pt]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
    }
    
    private func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: HomeViewController()),
            UIViewController(),
            UIViewController(),
            UINavigationController(rootViewController: WishViewController()),
            UINavigationController(rootViewController: MypageViewController())
        ]
        
        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
            tabs[$0.rawValue].tabBarItem.imageInsets = .init(top: 0, left: 0, bottom: -19.8, right: 0)
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    private func setDelegation() {
        self.delegate = self
    }
    
    private func tabBarItemBounceAnimation(imageView: UIImageView) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            
            imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

// MARK: - TabBarController Delegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabBarItemIndex = viewController.tabBarItem.tag
        
        
        switch tabBarItemIndex {
        case 1:
            selectedIndex = previousTabIndex
            self.navigationController?.pushViewController(MessageViewController(), animated: true)
            
            return false
        case 2:
            selectedIndex = previousTabIndex
            self.navigationController?.pushViewController(ArticleViewController(), animated: true)
            
            return false
        default:
            previousTabIndex = tabBarItemIndex
            return true
        }
    }
}
