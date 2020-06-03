//
//  CandleStickInteractor.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

class CandleStickInteractor {
    weak var output: CandleStickInteractorOutput?
    private let webService: DataWebServiceProtocol

    init(webService: DataWebServiceProtocol) {
        self.webService = webService
    }
}

// MARK: - CandleStickInteractorInteractorInput

extension CandleStickInteractor: CandleStickInteractorInput {
    func loadData(for timePeriod: TimeParserType) {
        webService.getInfoData(timeParseType: timePeriod, completion: { [weak self] result in
            switch result {
            case .success(let series):
                self?.output?.didLoadSeries(series: series)
            case .failure(let error):
                self?.output?.didLoadDataWithError(error: error)
            }
        })
    }

}
