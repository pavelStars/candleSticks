//
//  CandleStickModuleConfigurator.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

typealias CandleStickCompletionHandler = () -> Void

class CandleStickModuleConfigurator {
    public static func createModule(webRequestForTime: TimeParserType,
                                    errorHandler: ErrorHandler,
                                    completionHandler: @escaping CandleStickCompletionHandler) -> UIViewController {
        let storyboard = StoryboardProvider.getStoryboard(of: .main)
        let viewController = CandleStickViewController.controllerInStoryboard(storyboard)
        let interactor = CandleStickInteractor(webService: DataWebService())
        let presenter = CandleStickPresenter(view: viewController,
                                             interactor: interactor,
                                             errorHandler: errorHandler,
                                             completionHandler: completionHandler,
                                             timePeriod: webRequestForTime)

        interactor.output = presenter
        viewController.output = presenter

        return viewController
    }
}
