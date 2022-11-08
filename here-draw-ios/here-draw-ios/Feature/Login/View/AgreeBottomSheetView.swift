//
//  AgreeBottomSheetView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/08.
//

import UIKit

import SnapKit
import Then

class AgreeBottomSheetView: PassThroughView {
    // MARK: - Properties
    
    private weak var bottomSheetView: UIView!
    private weak var agreeView: UIView!
    private weak var allCheckButton: UIButton!
    private var agreementTermsData = [
        AgreementTerms(opened: false, title: ""
    ]
    
    enum Mode {
        case close
        case full
    }

    private enum Const {
        static let duration = 0.5
        static let cornerRadius = 20.0
        static let bottomSheetRatio: (Mode) -> Double = {
            switch $0 {
            case .close:
                return 1.0
            case .full:
                return 0.52
            }
        }
        
        static let bottomSheetYPosition: (Mode) -> Double = {
            Self.bottomSheetRatio($0) * DeviceUtils.height
        }
    }
    
    var mode: Mode = .full {
        didSet {
            switch self.mode {
            case .close:
                break
            case .full:
                break
            }
            self.updateConstraint(offset: Const.bottomSheetYPosition(self.mode))
        }
    }
    var bottomSheetColor: UIColor? {
        didSet { self.bottomSheetView.backgroundColor = self.bottomSheetColor }
    }
    var bottomSheetShadowColor: CGColor? {
        didSet { self.bottomSheetView.layer.shadowColor = self.bottomSheetShadowColor }
    }
    
    
    // MARK: - Function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.shadowColor = nil
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        self.addGestureRecognizer(panGesture)
        
//        bottomSheetView = UIView().then {
//            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            $0.layer.cornerRadius = Const.cornerRadius
//            $0.clipsToBounds = true
//            self.addSubview($0)
//
//            $0.snp.makeConstraints {
//                $0.leading.trailing.equalToSuperview()
//                $0.top.equalTo(Const.bottomSheetYPosition(.full))
//                $0.bottom.equalToSuperview()
//            }
//        }
//
//        let titleLabel = UILabel().then {
//            $0.text = "약관동의"
//            $0.textColor = .white1
//            $0.font = .sfPro25Pt2
//            bottomSheetView.addSubview($0)
//
//            $0.snp.makeConstraints {
//                $0.top.equalToSuperview().inset(50)
//                $0.leading.equalToSuperview().inset(22)
//            }
//        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    override func setLayout() {
        bottomSheetView = UIView().then {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = Const.cornerRadius
            $0.clipsToBounds = true
            $0.layer.shadowColor = UIColor.white.cgColor
            $0.layer.shadowOpacity = 0.9
            $0.layer.shadowOffset = CGSize(width: -414, height: -450)
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(Const.bottomSheetYPosition(.full))
                $0.bottom.equalToSuperview()
            }
        }
        
        let titleLabel = UILabel().then {
            $0.text = "약관동의"
            $0.textColor = .white1
            $0.font = .sfPro25Pt2
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(50)
                $0.leading.equalToSuperview().inset(22)
            }
        }
        
        agreeView = UIView().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 10.0
            $0.layer.borderColor = UIColor.pastelYellow.cgColor
            $0.layer.borderWidth = 2
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(26)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(60)
            }
        }
        
        let allCheckButton = UIButton().then {
            $0.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            $0.tintColor = .pastelYellow
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerY.equalTo(agreeView)
                $0.leading.equalTo(agreeView.snp.leading).inset(23)
                $0.size.equalTo(CGSize(width: 18, height: 18))
            }
        }
        
        let _ = UILabel().then {
            $0.text = "전체 동의"
            $0.textColor = .white1
            $0.font = .sfPro18Pt2
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerY.equalTo(agreeView)
                $0.leading.equalTo(allCheckButton.snp.trailing).offset(19)
            }
        }
    }
    
    private func updateConstraint(offset: Double) {
        bottomSheetView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(offset)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: objc func
    @objc
    private func didPan(_ recognizer: UIPanGestureRecognizer) {
        let transitionY = recognizer.translation(in: self).y
        let minY = self.bottomSheetView.frame.minY
        let offset = transitionY + minY
        
        if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.close) ~= offset {
            self.updateConstraint(offset: offset)
            recognizer.setTranslation(.zero, in: self)
        }
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: .curveEaseOut,
            animations: self.layoutIfNeeded,
            completion: nil
        )
        
        
        guard recognizer.state == .ended else { return }
        UIView.animate(
            withDuration: Const.duration,
            delay: 0,
            options: .allowUserInteraction,
            animations: {
                // 위로 스와이프, 아래로 스와이프인지 확인
                self.mode = recognizer.velocity(in: self).y >= 0 ? Mode.close: .full
            },
            completion: nil
        )
    }
}


