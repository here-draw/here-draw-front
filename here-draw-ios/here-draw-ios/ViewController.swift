//
//  ViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/12.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    private weak var label1: UILabel!
    private weak var label2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout() {
        // test
        label1 = UILabel().then {
            $0.font = .sfPro18Pt2
            $0.textColor = .white1
            $0.text = "안녕하세요."
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(50)
            }
        }
        
        label2 = UILabel().then {
            $0.font = .gmarketSans40Pt
            $0.textColor = .pastelYellow
            $0.text = "여기_그림"
            self.view.addSubview($0)

            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.label1.snp.bottom).offset(10)
            }
        }
    }
}

//MARK: - Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) -> UIView {
        ViewController().view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }

    typealias UIViewType = UIView
}

struct ViewController_Previews: PreviewProvider{
    static var previews: some View{
        ViewRepresentable()
    }
}
#endif


