//
//  CandleStickCoordinator.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

class CandleStickCoordinator: Coordinator {

    private var navigationController: UINavigationController
    private var errorHandler: ErrorHandler
    private var timePeriod: TimeParserType

    init(navigationController: UINavigationController,
         errorHandler: ErrorHandler,
         timePeriod: TimeParserType) {
        self.navigationController = navigationController
        self.errorHandler = errorHandler
        self.timePeriod = timePeriod
    }

    func start() {
        let candleStickModule = CandleStickModuleConfigurator.createModule(webRequestForTime: timePeriod,
                                                                           errorHandler: errorHandler,
                                                                           completionHandler: {

        })
        navigationController.pushViewController(candleStickModule, animated: true)
    }
}

protocol Coordinator: class {
    func start()
}
