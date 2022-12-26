//
//  ChartFactory.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import Foundation
import UIKit

protocol ChartFactory {
    static func chart(data: Data) -> UIView?
}

enum MyChartFactory: ChartFactory {
    static func chart(data: Data) -> UIView? {
        return viewFromJSONWithData(data)
    }
    
    static private func viewFromJSONWithData(_ data: Data) -> ChartView? {
        var chartView: ChartView? = nil
        if let chartStructure: ChartData = Parser.parseJSON(jsonData: data) {
            chartView = ChartView(chartData: chartStructure)
        }

        return chartView
    }
}

