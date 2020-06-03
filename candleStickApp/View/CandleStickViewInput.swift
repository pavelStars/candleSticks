//
//  CandleStickViewInput.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import Charts

protocol CandleStickViewInput: Activable {
    func display(dataSeries: [CandleChartDataEntry])
}
