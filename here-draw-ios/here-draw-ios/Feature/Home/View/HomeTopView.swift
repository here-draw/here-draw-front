//
//  HomeTopView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/20.
//

import UIKit

import ImageSlideshow
import Kingfisher
import SnapKit
import Then

class HomeTopView: BaseView {
    
    var completion: (() -> ())?
    public var banners: [ImageSource] = [] {
        didSet {
            bannerImageView.setImageInputs(banners)
        }
    }
    
    var pageIndicator: UIPageControl!
    var bannerImageView: ImageSlideshow!
    
    override func setLayout() {
        pageIndicator = UIPageControl().then {
            $0.currentPageIndicatorTintColor = .pastelYellow
            $0.pageIndicatorTintColor = .greyishLightBrown
            
            for subview in $0.subviews {
                subview.snp.remakeConstraints {
                    $0.width.height.equalTo(10)
                }
            }
        }
        
        bannerImageView = ImageSlideshow().then {
            $0.pageIndicator = pageIndicator
            $0.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center)
            $0.pageIndicatorPosition = PageIndicatorPosition(vertical: .bottom)
            $0.contentScaleMode = .scaleAspectFit
            $0.slideshowInterval = 3
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}

extension HomeTopView {
    @objc func showArticleCompilation() {
        completion?()
    }
}
