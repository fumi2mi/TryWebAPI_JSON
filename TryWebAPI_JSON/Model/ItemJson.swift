//
//  ItemJson.swift
//  TryWebAPI_JSON
//
//  Created by Fumitaka Imamura on 2021/11/17.
//

import Foundation

struct ItemJson: Codable {
    let name: String?
    let maker: String?
    let url: URL?
    let image: URL?
}
