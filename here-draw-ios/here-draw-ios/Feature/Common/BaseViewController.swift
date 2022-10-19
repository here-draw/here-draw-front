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
    
    func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .gray
        self.navigationItem.titleView?.isHidden = true
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func hierarchy() {}
    
    func setLayout() {}
}
