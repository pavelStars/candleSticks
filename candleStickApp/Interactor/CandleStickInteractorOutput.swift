//
//  CandleStickInteractorOutput.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

protocol CandleStickInteractorOutput: class {
    func didLoadSeries(series: [TimeSeries])
    func didLoadDataWithError(error: Error)
}
