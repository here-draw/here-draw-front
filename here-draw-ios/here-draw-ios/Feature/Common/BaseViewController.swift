//
//  BaseViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit

class BaseViewController: UIViewController {
    /* 뷰컨트롤러 MARK 컨벤션
    // MARK: - Properties

    // MARK: - View Life Cycle
    
    // MARK: - Functions
     
    // MARK: - Extensions
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black1
        hideNavigationBar()
        hierarchy()
        setLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // 네비게이션 바가 필요한 뷰컨에서 호출하기.
    func initNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // 네비게이션 바 커스텀해야 할 때, 뷰컨에서 오버라이딩 
    func setNavigationBar() {}
    
    func hierarchy() {}
    
    func setLayout() {}
}
