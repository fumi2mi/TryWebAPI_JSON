//
//  ResultJson.swift
//  TryWebAPI_JSON
//
//  Created by Fumitaka Imamura on 2021/11/17.
//

import Foundation

struct ResultJson: Codable {
    let item: [ItemJson]?
}
