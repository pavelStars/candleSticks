//
//  MontlyTimeSeries.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

struct TimeSeries: Codable {
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
}
