//
//  BottomSheetMode.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/08.
//

import UIKit

enum BottomSheetMode {
    case tip
    case full
}

private enum Const {
    static let bottomSheetRatio: (BottomSheetMode) -> Double = {
        switch $0 {
        case .tip:
            return 0.8
        case .full:
            return 0.2
        }
    }
    
    static let bottomSheetYPosition: (BottomSheetMode) -> Double = {
        Self.bottomSheetRatio($0) * DeviceUtils.height
    }
}
