//
//  HomeViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController {
    // MARK: - Properties
    
    private weak var navigationView: UIView!
    private weak var notificationButton: UIButton!
    private weak var searchButton: UIButton!
    private weak var homeTopView: UIView!
    private weak var containerView: PagerTab!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCategories()
    }
    
    // MARK: - Functions
    
    override func setLayout() {
        
        // 네비게이션 뷰
        navigationView = UIView(frame: CGRect(x: 0, y: 0, width: DeviceUtils.width, height: DeviceUtils.navigationBarHeight)).then {
            self.view.addSubview($0)
            
            
            $0.snp.makeConstraints() {
                $0.top.equalToSuperview().inset(DeviceUtils.statusBarHeight)
                $0.leading.equalToSuperview()
            }
        }
        
        // 타이틀
        let title = UILabel().then {
            $0.text = "여기_그림"
            $0.font = .gmarketSans20Pt
            $0.textColor = .pastelYellow
            navigationView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(14)
                $0.leading.equalToSuperview().inset(20)
            }
        }
        
        // 검색 버튼
        searchButton = UIButton().then {
            let image = UIImage(named: "search")
            $0.setImage(image, for: .normal)
            navigationView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(title.snp.top)
                $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(22)
            }
        }
        
        // 알림 버튼
        notificationButton = UIButton().then {
            $0.setImage(UIImage(named: "notification"), for: .normal)
            navigationView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(title.snp.top)
                $0.trailing.equalTo(self.searchButton.snp.leading).inset(UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0))
            }
        }
        
        let scrollView = UIScrollView().then {
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(DeviceUtils.statusBarHeight)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(DeviceUtils.width)
                $0.centerX.equalToSuperview()
            }
        }
        
        let stackView = UIStackView().then {
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
        homeTopView = UIView().then {
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
                $0.height.equalTo(1000).priority(700)
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
        // TODO: API fetch (차후 뷰모델로 옮기기)
        return ["전체", "캐릭터", "풍경화", "만화", "인물화", "기타"]
    }
}

// MARK: - Extensions

//MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewRepresentable: UIViewRepresentable{
    typealias UIViewType = UIView
    private let vc = HomeViewController()
    
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
