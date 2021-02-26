//
//  GameItemTableViewCell.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/20.
//

import Kingfisher
import SnapKit
import UIKit

class GameItemCell: UITableViewCell {
    // MARK: - ViewModel
    private let viewModel: GameListCellViewModel = GameListCellViewModel()
    
    // MARK: - Views
    private lazy var gameImageView: UIImageView = UIImageView()
    private lazy var gameTitleLabel: UILabel = UILabel()
    private lazy var gameOriginPriceLabel: UILabel = UILabel()
    private lazy var gameSalePriceLabel: UILabel = UILabel()
    private lazy var stackView: UIStackView = UIStackView()
    
    // MARK: - 코드로 셀을 입력해주기 위한 부분
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 레이아웃을 설정해준다.
        setConstraints()
        
        // bind를 해준다!
        bind(viewModel: viewModel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController에서 호출하는 메서드
    func updateData(_ model: GameContents) {
        viewModel.updateData(model: model)
    }
}

// MARK: - Layout Constraints (private)
extension GameItemCell {
    private func setConstraints() {
        setGameImageView()
        setGameTitleLabel()
        setStackView()
        setGameOriginPriceLabel()
        setGameSalePriceLabel()
    }
    private func setGameImageView() {
        self.contentView.addSubview(gameImageView)
        gameImageView.backgroundColor = .lightGray
        gameImageView.layer.cornerRadius = 9
        gameImageView.snp.makeConstraints { make in
            make.width.equalTo(122)
            make.height.equalTo(69)
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    private func setGameTitleLabel() {
        self.contentView.addSubview(gameTitleLabel)
        gameTitleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        gameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(gameImageView.snp.trailing).offset(12)
        }
    }
    private func setStackView() {
        self.contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.snp.makeConstraints { make in
            make.top.equalTo(gameTitleLabel.snp.bottom)
            make.leading.equalTo(gameTitleLabel)
        }
    }
    private func setGameOriginPriceLabel() {
        stackView.addArrangedSubview(gameOriginPriceLabel)
        gameOriginPriceLabel.font = .systemFont(ofSize: 12)
        gameOriginPriceLabel.textColor = .veryLightPink
    }
    private func setGameSalePriceLabel() {
        stackView.addArrangedSubview(gameSalePriceLabel)
        gameSalePriceLabel.font = .systemFont(ofSize: 12)
        gameSalePriceLabel.textColor = .red
    }
}

// MARK: - ViewModel Observer
// viewmodel이 변경되면 view는 다음과 같은 클로저들을 호출하게 된다.
extension GameItemCell: GameItemCellViewModelObserver {
    func bind(viewModel: GameListCellViewModel) {
        bindTitle(viewModel: viewModel)
        bindThumbnailURL(viewModel: viewModel)
        bindOriginPrice(viewModel: viewModel)
        bindSalePrice(viewModel: viewModel)
    }
    // title이 변경되면
    func bindTitle(viewModel: GameListCellViewModel) {
        viewModel.title.didSetValue { [weak self] title in
            self?.gameTitleLabel.text = title
        }
    }
    // url이 변경되면
    func bindThumbnailURL(viewModel: GameListCellViewModel) {
        viewModel.thumbnailURL.didSetValue { thumbnailURL in
            let imageURL: URL? = URL(string: thumbnailURL)
            self.gameImageView.kf.setImage(with: imageURL)
        }
    }
    // origin 가격이 변경되면
    func bindOriginPrice(viewModel: GameListCellViewModel) {
        viewModel.originPrice?.didSetValue { originPrice in
            self.gameOriginPriceLabel.text = "\(originPrice)"
        }
    }
    // sale 가격이 변경되면
    func bindSalePrice(viewModel: GameListCellViewModel) {
        viewModel.salePrice.didSetValue { salePrice in
            self.gameSalePriceLabel.text = "\(salePrice)"
        }
    }
}
