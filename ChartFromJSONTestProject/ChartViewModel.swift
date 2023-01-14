//
//  ChartViewModel.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 11.01.2023.
//

import UIKit

class ChartViewModel {
    let chartData: ChartData
    let identifiedSeries: Series
    let hospitalizedSeries: Series
    let recoveredSeries: Series
    let identifiedColor: UIColor
    let hospitalizedColor: UIColor
    let recoveredColor: UIColor

    init(chartData: ChartData, identifiedSeries: Series, hospitalizedSeries: Series, recoveredSeries: Series) {
        self.chartData = chartData
        self.identifiedSeries = identifiedSeries
        self.hospitalizedSeries = hospitalizedSeries
        self.recoveredSeries = recoveredSeries
        self.identifiedColor = UIColor(rgbString: identifiedSeries.color)
        self.hospitalizedColor = UIColor(rgbString: hospitalizedSeries.color)
        self.recoveredColor = UIColor(rgbString: recoveredSeries.color)
    }
}
