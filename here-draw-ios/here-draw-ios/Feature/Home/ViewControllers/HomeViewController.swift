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
        
        let viewControllers: [PageComponentProtocol] = [
            HomeListViewController(),
            HomeListViewController(),
            HomeListViewController(),
            HomeListViewController(),
            HomeListViewController()
        ]
        let style = PagerTab.Style.default
        containerView.setup(self, viewControllers: viewControllers, style: style)
    }
    
    // MARK: - Functions
    
    override func setLayout() {
        // 네비게이션 뷰
        navigationView = UIView(frame: CGRect(x: 0, y: 0, width: DeviceUtils.width, height: DeviceUtils.navigationBarHeight)).then {
            $0.backgroundColor = .gray
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
                $0.top.leading.equalToSuperview().inset(20)
            }
        }
        
        // 검색 버튼
        searchButton = UIButton().then {
            let image = UIImage(named: "search")
            $0.setImage(image, for: .normal)
            navigationView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(title.snp.top)
                $0.bottom.equalToSuperview().inset(26)
                $0.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(22)
            }
        }
        
        // 알림 버튼
        notificationButton = UIButton().then {
            $0.setImage(UIImage(named: "notification"), for: .normal)
            navigationView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(title.snp.top)
                $0.bottom.equalToSuperview().inset(26)
                $0.trailing.equalTo(self.searchButton.snp.leading).inset(UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0))
            }
        }
        
        // 탑뷰(배너뷰)
        homeTopView = UIView().then {
            $0.backgroundColor = .red
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(navigationView.snp.bottom)
                $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
                $0.height.equalTo(170)
            }
        }
        
        // 컨테이너뷰(작품 리스트 탭 뷰)
        containerView = PagerTab().then {
            self.view.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(self.homeTopView.snp.bottom)
                $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            }
        }
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
