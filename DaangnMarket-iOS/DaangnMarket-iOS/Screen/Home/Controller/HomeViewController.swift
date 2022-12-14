//
//  HomeViewController.swift
//  DaangnMarket-iOS
//
//  Created by 황찬미 on 2022/08/07.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let tableView = UITableView().then {
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    private let navigationBar = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let navigationLine = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    private let placeLabel = UILabel().then {
        $0.text = "상봉제 1동"
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.sizeToFit()
    }
    
    private let searchButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icSearch, for: .normal)
    }
    
    private let menuButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icMenu, for: .normal)
    }
    
    private let bellButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icBell, for: .normal)
    }
    
    private let naviButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fillEqually
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setLayout()
        setTableView()
    }
    
    // MARK: - Custom Method
    
    private func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setLayout() {
        view.addSubviews([navigationBar,
                          navigationLine,
                          placeLabel,
                          naviButtonStackView,
                          tableView])
        naviButtonStackView.addArrangedSubview(searchButton)
        naviButtonStackView.addArrangedSubview(menuButton)
        naviButtonStackView.addArrangedSubview(bellButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        navigationLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(navigationBar)
            $0.height.equalTo(1)
        }
        
        placeLabel.snp.makeConstraints {
            $0.centerY.equalTo(navigationBar)
            $0.leading.equalToSuperview().inset(16)
        }
        
        naviButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(navigationBar)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        cell.setData(HomeDataModel.itemImages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeDataModel.itemImages.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.imageData = HomeDataModel.itemImages[indexPath.row].itemImage
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
}
