//
//  ResponseObject.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

struct ResponseObject: Decodable {
    var monthlyTimeSeriesList: TimeSeries?
    enum CodingKeys: String, CodingKey {
           case monthlyTimeSeriesList = "Monthly Time Series"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            monthlyTimeSeriesList = try container.decode(TimeSeries.self, forKey: .monthlyTimeSeriesList)
        } catch let error {
            print(error)
            monthlyTimeSeriesList = nil
        }
    }
}
