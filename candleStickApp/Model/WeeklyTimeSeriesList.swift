//
//  WeeklyTimeSeriesList.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 3.06.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

struct WeeklyTimeSeriesList: Decodable {
    let arrayWeeklyTimeSeries: [TimeSeries]
    enum CodingKeys: String, CodingKey {
        case arrayDailyTimeSeries = "Weekly Time Series"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let responseDict = try container.decode([String: [String: String]].self, forKey: .arrayDailyTimeSeries)
            var series: [TimeSeries] = []
            for (_, value) in responseDict {
                let infoDict = value
                if let infoOpen = infoDict["1. open"],
                    let infoHigh = infoDict["2. high"],
                    let infoLow = infoDict["3. low"],
                    let infoClose = infoDict["4. close"],
                    let infoVolume = infoDict["5. volume"] {
                    let objectSerie = TimeSeries(open: infoOpen,
                                                 high: infoHigh,
                                                 low: infoLow,
                                                 close: infoClose,
                                                 volume: infoVolume)
                    series.append(objectSerie)
                }
            }
            arrayWeeklyTimeSeries = series
        } catch let error {
            print(error)
            arrayWeeklyTimeSeries = []
        }
    }
}
