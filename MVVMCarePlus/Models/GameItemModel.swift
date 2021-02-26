//
//  GameItemModel.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/20.
//
import Foundation

struct GameItemModel {
    let gameTitle: String
    let gameOriginPrice: Int
    let gameDiscountPrice: Int?
    let imageURL: String
    let screenshotURLs: [String]
}
