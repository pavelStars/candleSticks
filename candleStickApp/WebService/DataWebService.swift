//
//  DataWebService.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import Foundation

// could be updated with URLRequestParams
private enum Constants {
    static let mainURL = "https://www.alphavantage.co/query?function=TIME_SERIES_"
    static let urlAppendix = "&symbol=MSFT&apikey=demo"
}

enum TimeParserType {
    case daily
    case weekly
    case monthly
}

protocol DataWebServiceProtocol {
    func getInfoData(timeParseType: TimeParserType,
                     completion: @escaping (Result<[TimeSeries], Error>) -> Void)
}

class DataWebService: DataWebServiceProtocol {
    func getInfoData(timeParseType: TimeParserType,
                     completion: @escaping (Result<[TimeSeries], Error>) -> Void) {
        var timePeriod: String = ""
        switch timeParseType {
        case .daily:
            timePeriod = "DAILY"
        case .monthly:
            timePeriod = "MONTHLY"
        case .weekly:
            timePeriod = "WEEKLY"
        }
        let finalURL = Constants.mainURL + timePeriod + Constants.urlAppendix

        guard let url = URL(string: finalURL) else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] result in
            switch result {
            case .success(_, let data):
                var monthlyTimeSeries: [TimeSeries] = []

                guard let resultArray = self?.infoArrayAfterParsing(type: timeParseType, data: data) else {
                    return
                }

                monthlyTimeSeries = resultArray
                let result: Result = .wrapWebServiceResult(success: true,
                                                           result: monthlyTimeSeries,
                                                           error: nil)
                DispatchQueue.main.async {
                    completion(result)
                }

                break
            case .failure(let error):
                break
            }

        }.resume()
    }

    private func infoArrayAfterParsing(type: TimeParserType, data: Data) -> [TimeSeries] {
        switch type {
        case .daily:
            guard let arrayInfo = try? JSONDecoder().decode(DailyTimeSeriesList.self, from: data) else {
                return []
            }
            return arrayInfo.arrayDailyTimeSeries
        case .monthly:
            guard let arrayInfo = try? JSONDecoder().decode(MonthlyTimeSeries.self, from: data) else {
                return []
            }
            return arrayInfo.arrayMonthlyTimeSeries
        case .weekly:
            guard let arrayInfo = try? JSONDecoder().decode(WeeklyTimeSeriesList.self, from: data) else {
                return []
            }
            return arrayInfo.arrayWeeklyTimeSeries
        }
    }
}

extension URLSession {
    func dataTask(with url: URL,
                  result: @escaping (Result<(URLResponse, Data),
                      Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { data, response, error in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
