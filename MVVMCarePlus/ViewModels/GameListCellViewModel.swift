//
//  GameListCellViewModel.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/23.
//

import Foundation

protocol GameItemCellViewModelObserver {
    func bind(viewModel: GameListCellViewModel)
    func bindTitle(viewModel: GameListCellViewModel)
    func bindThumbnailURL(viewModel: GameListCellViewModel)
    func bindOriginPrice(viewModel: GameListCellViewModel)
    func bindSalePrice(viewModel: GameListCellViewModel)
}

class GameListCellViewModel {
    // 셀에서 필요한 데이터
    var title: VMData<String>
    var thumbnailURL: VMData<String>
    var originPrice: VMData<Int>?
    var salePrice: VMData<Int>
    
    init() {
        self.title = VMData("Title")
        self.thumbnailURL = VMData("ThumbnailURL")
        self.salePrice = VMData(10_000)
    }
    
    init(model: GameContents) {
        self.title = VMData(model.formalName)
        self.thumbnailURL = VMData(model.heroBannerURL)
        self.salePrice = VMData(10_000)
    }
    
    func updateData(model: GameContents) {
        self.title.value = model.formalName
        self.thumbnailURL.value = model.heroBannerURL
        self.salePrice.value = 10_000
    }
}
