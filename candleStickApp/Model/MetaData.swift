//
//  MetaData.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

struct MetaData: Codable {
    let information: String
    let symbol: String
    let lastTimeRefreshed: String
    let timeZone: String

    private enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastTimeRefreshed = "3. Last Refreshed"
        case timeZone = "4. Time Zone"
    }
}
