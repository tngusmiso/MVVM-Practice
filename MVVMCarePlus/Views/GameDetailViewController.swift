//
//  GameDetailViewController.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/23.
//
import SnapKit
import UIKit

class GameDetailViewController: UIViewController {
    private let viewModel: GameDetailViewModel = GameDetailViewModel()
    private lazy var containerView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(containerView)
        containerView.backgroundColor = .darkGray
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? GameDetailPageViewController)?.viewModel = viewModel
    }
}
