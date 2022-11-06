//
//  OnboardingCollectionViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/05.
//

import UIKit

import SnapKit
import Then

class OnboardingCollectionViewCell: UICollectionViewCell {
    private weak var imageView: UIImageView!
    private weak var contentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        imageView.image = nil
        contentLabel.text = nil
    }
}

extension OnboardingCollectionViewCell {
    public func fetchItem(image: UIImage, text: String) {
        imageView.image = image
        contentLabel.text = text
    }
    
    private func setLayout() {
        contentView.backgroundColor = .black1
        
        imageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
            }
        }
        
        contentLabel = UILabel().then {
            $0.font = .gmarketSans15Pt
            $0.textColor = .lightGrey
            $0.sizeToFit()
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(17)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }
        
    }
}
