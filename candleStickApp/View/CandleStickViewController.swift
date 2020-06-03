//
//  CandleStickViewController.swift
//  candleStickApp
//
//  Created by Pavel Terziyski on 31.05.20.
//  Copyright (c) 2020 Pavel Terziyski. All rights reserved.
//

import Charts
import UIKit

class CandleStickViewController: UIViewController {
    @IBOutlet private var chartView: CandleStickChartView!
    var output: CandleStickViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.loadData()
    }

    private func setupChartView() {
        chartView.delegate = self

        chartView.chartDescription?.enabled = false

        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true

        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!

        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0

        chartView.rightAxis.enabled = false

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
    }

    func updateWith(entities: [CandleChartDataEntry]) {
        let set1 = CandleChartDataSet(entries: entities, label: "Data Set")
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80 / 255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.shadowColor = .darkGray
        set1.shadowWidth = 0.7
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122 / 255, green: 242 / 255, blue: 84 / 255, alpha: 1)
        set1.increasingFilled = false
        set1.neutralColor = .blue

        let data = CandleChartData(dataSet: set1)
        chartView.data = data
    }
}

extension CandleStickViewController: CandleStickViewInput {
    func display(dataSeries: [CandleChartDataEntry]) {
        updateWith(entities: dataSeries)
    }
}

extension CandleStickViewController: ChartViewDelegate {
}
