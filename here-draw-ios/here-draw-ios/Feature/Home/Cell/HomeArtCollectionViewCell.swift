//
//  HomeArtCollectionViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/19.
//

import UIKit

protocol HomeArtCollectionViewCellDelegate: AnyObject {
    func collectionView(_ collectionView:UICollectionView, heightForTextAtIndexPath indexPath:IndexPath) -> CGFloat
}

class HomeArtCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: HomeArtCollectionViewCellDelegate!
    
    private weak var artImageView: UIImageView!
    private weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artImageView.removeFromSuperview()
        nameLabel.removeFromSuperview()
    }
    
    deinit {
        artImageView.image = nil
        nameLabel.text = nil
    }
}

//MARK: - Functions

extension HomeArtCollectionViewCell {
    
    public func fetchItem(model: HomeArtModel) {
        artImageView.image = model.thumbnail
        nameLabel.text = model.name
    }
    
    public func nameLabelHeigth() -> CGFloat {
        return nameLabel.frame.height
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
            $0.numberOfLines = 2
            self.contentView.addSubview($0)
            
            
            $0.snp.makeConstraints{
                $0.top.equalTo(self.artImageView.snp.bottom).offset(9)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
