//
//  HomeViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit

import ImageSlideshow
import SnapKit
import Then

class HomeViewController: BaseViewController {
    // MARK: - Properties
    
    let bannerImages = [
        UIImage(named: "poster")!,
        UIImage(named: "poster")!,
        UIImage(named: "poster")!
    ]
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var homeTopView: HomeTopView!
    private weak var containerView: PagerTab!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setNavigationBar()
        fetchBanner(images: bannerImages)
        setCategories()
    }
    
    // MARK: - Functions
    
    override func setNavigationBar() {
        let naviBar = NavigationBarView(frame: CGRect(x: 0, y: DeviceUtils.statusBarHeight, width: DeviceUtils.width, height: 60))
        
        let naviItem = UINavigationItem()
        naviItem.setTitleView(style: UINavigationItem.titleStyle(
            pos: .center,
            text: "여기_그림",
            font: .gmarketSans20Pt,
            color: .pastelYellow)
        )
        
        let notiButton = UINavigationItem.buttonStyle(
            image: UIImage(named: "notification")!,
            color: .white1,
            action: #selector(self.testSelector)
        )
        let searchButton = UINavigationItem.buttonStyle(
            image: UIImage(named: "search")!,
            color: .white1,
            action: #selector(self.testSelector)
        )
        naviItem.setBarButton(pos: .right, styles: notiButton, searchButton)
        naviBar.items = [naviItem]
        
        view.addSubview(naviBar)
    }
    
    @objc func testSelector() {
        print("👀 success selector")
    }
    
    override func setLayout() {
        scrollView = UIScrollView().then {
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(DeviceUtils.width)
                $0.centerX.equalToSuperview()
            }
        }
        
        stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 0
            $0.distribution = .fill
            scrollView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
        
        // 탑뷰(배너뷰)
        homeTopView = HomeTopView().then {
            $0.bannerImageView.delegate = self
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.height.equalTo(170)
            }
        }
        
        // 컨테이너뷰(작품 리스트 탭 뷰)
        containerView = PagerTab().then {
            stackView.addArrangedSubview($0)

            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1000)
            }
        }
    }
    
    private func setCategories() {
        let viewControllers = getCategories().map {
            HomeListViewController(type: $0)
        }
        let style = PagerTab.Style.default
        containerView.setup(self, viewControllers: viewControllers, style: style)
    }

    private func getCategories() -> [String] {
        // TODO: API fetch category (차후 뷰모델로 옮기기)
        return ["전체", "캐릭터", "풍경화", "만화", "인물화", "기타"]
    }
    
    private func fetchBanner(images: [UIImage]) {
        // TODO: API fetch banner (차후 뷰모델로 옮기기)
        images.forEach {
            homeTopView.banners.append(ImageSource(image: $0))
        }
    }
}

// MARK: - Extensions

extension HomeViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        return
    }
}

//MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewRepresentable: UIViewRepresentable{
    typealias UIViewType = UIView
    private let vc = UINavigationController(rootViewController: HomeViewController())
    
    func makeUIView(context: Context) -> UIView {
        vc.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // 데이터 로드 필요할 때
        // vc.tableView.reloadData()
    }
}

struct ViewController_Previews: PreviewProvider{
    static var previews: some View{
        ViewRepresentable()
    }
}
#endif
