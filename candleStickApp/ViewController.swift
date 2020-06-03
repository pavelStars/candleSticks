//
//  ViewController.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright © 2020 Pavel Terziyski. All rights reserved.
//

import UIKit

private enum Constats {
    static let dailyTimePeriod = TimeParserType.daily
    static let weeklyTimePeriod = TimeParserType.weekly
    static let monthlyTimePeriod = TimeParserType.monthly
}

class ViewController: UIViewController {
    @IBOutlet private weak var dailyButton: UIButton!
    @IBOutlet private weak var weeklyButton: UIButton!
    @IBOutlet private weak var monthlyButton: UIButton!

    private var errorHandler: ErrorHandler!
    private var candleStickCoordinator: CandleStickCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        setupErrorHandler()
        // Do any additional setup after loading the view.
    }

    private func setupErrorHandler() {
        errorHandler = ErrorHandler(viewController: self)
    }

    private func configureButtons() {
        dailyButton.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
        weeklyButton.addTarget(self, action: #selector(weeklyButtonTapped), for: .touchUpInside)
        monthlyButton.addTarget(self, action: #selector(monthlyButtonTapped), for: .touchUpInside)
    }

    private func startCandleCoordinatorWithTimePeriod(timePeriod: TimeParserType) {
        guard let navigationViewController = navigationController else {
            return
        }

        candleStickCoordinator = CandleStickCoordinator(navigationController: navigationViewController,
                                                        errorHandler: errorHandler,
                                                        timePeriod: timePeriod)
        candleStickCoordinator?.start()
    }

    @objc private func dailyButtonTapped() {
        startCandleCoordinatorWithTimePeriod(timePeriod: Constats.dailyTimePeriod)
    }

    @objc private func weeklyButtonTapped() {
        startCandleCoordinatorWithTimePeriod(timePeriod: Constats.weeklyTimePeriod)
    }

    @objc private func monthlyButtonTapped() {
        startCandleCoordinatorWithTimePeriod(timePeriod: Constats.monthlyTimePeriod)
    }
}
