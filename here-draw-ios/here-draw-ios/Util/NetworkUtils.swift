//
//  NetworkUtils.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/17.
//

import Foundation

class NetworkUtils {
    static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
}
