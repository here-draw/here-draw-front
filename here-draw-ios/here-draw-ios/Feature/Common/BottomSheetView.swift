//
//  BottomSheetView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/08.
//

import UIKit

import SnapKit
import Then

class BottomSheetView: PassThroughView {
    // MARK: - Properties
    
    public var bottomSheetView: UIView!
    
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
        
        bottomSheetView = UIView().then {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = Const.cornerRadius
            $0.clipsToBounds = true
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(Const.bottomSheetYPosition(.full))
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    override func setLayout() {
        bottomSheetView = UIView().then {
            $0.backgroundColor = .red
            $0.layer.shadowColor = UIColor.white.cgColor
            $0.layer.shadowOpacity = 0.9
            $0.layer.shadowOffset = CGSize(width: -100, height: -100)
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


