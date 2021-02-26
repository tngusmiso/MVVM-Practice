//
//  NewGameResponse.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/20.
//

import Foundation

struct NewGameScreenshotImage: Decodable {
    let url: String
}

struct NewGameScreenshot: Decodable {
    let images: [NewGameScreenshotImage]
}

struct GameContents: Decodable {
    let formalName: String
    let heroBannerURL: String
    let screenshots: [NewGameScreenshot]
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case screenshots
    }
}

struct GameListResponse: Decodable {
    var contents: [GameContents]
    let length: Int
    let offset: Int
    let total: Int
}
