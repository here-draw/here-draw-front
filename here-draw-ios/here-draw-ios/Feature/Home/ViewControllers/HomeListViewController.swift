//
//  HomeListViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/19.
//

import UIKit

//enum CategoryType: Int, CaseIterable {
//    case all
//    case character
//    case landscape
//    case cartoon
//    case portrait
//    case etc
//}

class HomeListViewController: BaseViewController, PageComponentProtocol {
    // MARK: - Properties
    
    var pageTitle: String
    let artModels = HomeArtModel.dummy
    
    fileprivate var artCollectionView: UICollectionView!
    

    // MARK: - View Life Cycle
    
    init(type: String) {
        self.pageTitle = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Functions
    
    override func setLayout() {
        self.view.backgroundColor = .black1
        
        let flowLayout = UICollectionViewFlowLayout().then {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            $0.scrollDirection = .vertical
            
        }
        
        artCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(HomeArtCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            $0.backgroundColor = .black1
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            }
        }
    }
}

// MARK: - Extension UICollectionViewDataSource

extension HomeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeArtCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.fetchItem(model: artModels[indexPath.item])
        
        cell.prepareForReuse()
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension HomeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeArtCollectionViewCell
        else {
            return CGSize(width: 177, height: 350)
        }
        
        let cellWidth = (collectionView.frame.width - 60) / 2 - 1
//        let cellHeight = cell.contentView.systemLayoutSizeFitting(CGSize(width: cellWidth, height: UIView.layoutFittingCompressedSize.height)).height
        
        cell.prepareForReuse()
        
        return CGSize(width: cellWidth, height: 350)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
