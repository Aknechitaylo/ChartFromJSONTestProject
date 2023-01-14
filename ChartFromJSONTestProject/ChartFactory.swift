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
        viewFromJSONWithData(data)
    }
    
    static private func viewFromJSONWithData(_ data: Data) -> ChartView? {
        if let chartData: ChartData = Parser.parseJSON(jsonData: data) {
            let viewModel = ChartViewModel(chartData: chartData,
                                           identifiedSeries: chartData.seriesWithId(100) ?? .default,
                                           hospitalizedSeries: chartData.seriesWithId(200) ?? .default,
                                           recoveredSeries: chartData.seriesWithId(300) ?? .default)
            
            return ChartView(chartViewModel: viewModel)
        }
        
        return nil
    }
}

