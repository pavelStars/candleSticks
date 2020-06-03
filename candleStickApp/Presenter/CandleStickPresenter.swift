//
//  CandleStickPresenter.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import Charts

class CandleStickPresenter {
    unowned var view: CandleStickViewInput
    var interactor: CandleStickInteractorInput
    var errorHandler: ErrorHandler?
    var completionHandler: CandleStickCompletionHandler?
    private let timePeriod: TimeParserType

    private var allSeries: [TimeSeries] = [] {
        didSet {
            var entities: [CandleChartDataEntry] = []

            for i in 0 ..< allSeries.count {
                if let shadowH = Double(allSeries[i].high),
                    let shadowL = Double(allSeries[i].low),
                    let open = Double(allSeries[i].open),
                    let close = Double(allSeries[i].close) {
                    let entity = CandleChartDataEntry(x: Double(i), shadowH: shadowH, shadowL: shadowL, open: open, close: close)
                    entities.append(entity)
                }
            }
            view.display(dataSeries: entities)
        }
    }

    init(view: CandleStickViewInput,
         interactor: CandleStickInteractorInput,
         errorHandler: ErrorHandler?,
         completionHandler: CandleStickCompletionHandler?,
         timePeriod: TimeParserType) {
        self.view = view
        self.interactor = interactor
        self.errorHandler = errorHandler
        self.completionHandler = completionHandler
        self.timePeriod = timePeriod
    }

    private func loadInfo() {
        view.startActivityIndicator()
        interactor.loadData(for: timePeriod)
    }
}

// MARK: - CandleStickPresenterViewOutput

extension CandleStickPresenter: CandleStickViewOutput {
    func viewIsReady() {
    }

    func loadData() {
        loadInfo()
    }
}

// MARK: - CandleStickPresenterInteractorOutput

extension CandleStickPresenter: CandleStickInteractorOutput {
    func didLoadSeries(series: [TimeSeries]) {
        view.stopActivityIndicator()
        allSeries = series
    }

    func didLoadDataWithError(error: Error) {
        errorHandler?.handleError(error)
    }
}
