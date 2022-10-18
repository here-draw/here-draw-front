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
        hideNavigationBar()
        setLayout()
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .black1
        self.navigationItem.titleView?.isHidden = true
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setLayout() {}
}
