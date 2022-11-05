//
//  HomeArtModel.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/21.
//

import UIKit

struct HomeArtModel {
    var thumbnail: UIImage
    var name: String
}

extension HomeArtModel {
    static var dummy: [HomeArtModel] = [
        HomeArtModel(thumbnail: UIImage(named: "artDummy1")!, name: "일러스트제목이 두 줄이상 넘어갔을때 예시입니다 와라라라라라라라라라…"),
        HomeArtModel(thumbnail: UIImage(named: "artDummy2")!, name: "아네모네 커버일러스트"),
        HomeArtModel(thumbnail: UIImage(named: "artDummy3")!, name: "이미지"),
        HomeArtModel(thumbnail: UIImage(named: "artDummy4")!, name: "이미지")
    ]
}
