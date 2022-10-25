//
//  HomeArtCollectionViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/19.
//

import UIKit

class HomeArtCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private weak var artImageView: UIImageView!
    private weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - Functions

extension HomeArtCollectionViewCell {
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        artImageView.
//    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        
        layoutAttributes.bounds.size.height = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        return layoutAttributes
    }
    
    public func fetchItem(model: HomeArtModel) {
        artImageView.image = model.thumbnail
        nameLabel.text = model.name
    }
    
    private func setLayout() {
        artImageView = UIImageView().then {
            $0.layer.cornerRadius = 3
            self.contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
        }
        
        nameLabel = UILabel().then{
            $0.textColor = .white1
            $0.font = .sfPro11Pt2
            self.contentView.addSubview($0)
            
            
            $0.snp.makeConstraints{
                $0.top.equalTo(self.artImageView.snp.bottom).offset(9)
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview().inset(24)
            }
        }
    }
}
