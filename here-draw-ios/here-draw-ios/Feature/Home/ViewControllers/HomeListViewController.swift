//
//  HomeListViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/19.
//

import UIKit

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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setCollectionViewHeight()
//        artCollectionView.reloadData()
        artCollectionView.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - Functions
    
    func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {
        // fake label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude)).then {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = .sfPro11Pt2
            $0.text = text
            $0.sizeToFit()
        }
        return label.frame.height
    }
    
//    func setCollectionViewHeight() {
//        artCollectionView.snp.makeConstraints {
//            $0.height.equalTo(artCollectionView.collectionViewLayout.collectionViewContentSize.height)
//        }
//    }
    
    override func setLayout() {
        self.view.backgroundColor = .systemBackground
        
        let layout = PinterestLayout().then {
            $0.delegate = self
        }
        
        artCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.dataSource = self
            $0.register(HomeArtCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            $0.backgroundColor = .black1
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalTo(self.view.safeAreaInsets)
            }
        }
        view.layoutIfNeeded()
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
        return cell
    }
}

// MARK: - Extension PinterestLayoutDelegate

extension HomeListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let imgHeight = artModels[indexPath.item].thumbnail.scaledHeight(scaledWidth: cellWidth)
        
        let textHeight = requiredHeight(text: artModels[indexPath.item].name, cellWidth: cellWidth)
        
        return imgHeight + textHeight + 5
    }
}
