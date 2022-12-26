//
//  ChartView.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import Foundation
import UIKit
import SnapKit

class ChartView: UIView {
    let chartData: ChartData
    let identifiedSeries: Series
    let hospitalizedSeries: Series
    let recoveredSeries: Series
    let identifiedColor: UIColor
    let hospitalizedColor: UIColor
    let recoveredColor: UIColor
    let identifiedDot: UIView
    let hospitalizedDot: UIView
    let recoveredDot: UIView
    let identifiedLabel: UILabel
    let hospitalizedLabel: UILabel
    let recoveredLabel: UILabel
    let chartContainer = UIView()
    let chartSeparatorView = UIView(color: .systemGray4)
    let seriesStackView = UIStackView()

    init(chartData: ChartData) {
        self.chartData = chartData
        identifiedSeries = chartData.seriesWithId(100)!
        hospitalizedSeries = chartData.seriesWithId(200)!
        recoveredSeries = chartData.seriesWithId(300)!
        identifiedColor = UIColor(rgbString: identifiedSeries.color)
        hospitalizedColor = UIColor(rgbString: hospitalizedSeries.color)
        recoveredColor = UIColor(rgbString: recoveredSeries.color)
        identifiedDot = UIView(color: identifiedColor)
        hospitalizedDot = UIView(color: hospitalizedColor)
        recoveredDot = UIView(color: recoveredColor)
        identifiedLabel = UILabel(text: identifiedSeries.name, color: .systemGray)
        hospitalizedLabel = UILabel(text: hospitalizedSeries.name, color: .systemGray)
        recoveredLabel = UILabel(text: recoveredSeries.name, color: .systemGray)
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupDotsSegment()
        setupChartSegment()
    }
    
    private func setupDotsSegment() {
        let dotHeight = 15
        
        addSubview(identifiedDot)
        identifiedDot.snp.makeConstraints { make in
            make.height.width.equalTo(dotHeight)
            make.top.equalTo(20)
            make.leading.equalTo(35)
        }
        identifiedDot.layer.cornerRadius = CGFloat(dotHeight/2)
        addSubview(identifiedLabel)
        identifiedLabel.snp.makeConstraints { make in
            make.leading.equalTo(identifiedDot.snp.trailing).offset(7)
            make.centerY.equalTo(identifiedDot.snp.centerY)
        }
        
        addSubview(hospitalizedDot)
        hospitalizedDot.snp.makeConstraints { make in
            make.height.width.equalTo(dotHeight)
            make.top.equalTo(identifiedDot.snp.top)
            make.leading.equalTo(identifiedLabel.snp.trailing).offset(20)
        }
        hospitalizedDot.layer.cornerRadius = CGFloat(dotHeight/2)
        addSubview(hospitalizedLabel)
        hospitalizedLabel.snp.makeConstraints { make in
            make.leading.equalTo(hospitalizedDot.snp.trailing).offset(7)
            make.centerY.equalTo(identifiedDot.snp.centerY)
        }
        
        addSubview(recoveredDot)
        recoveredDot.snp.makeConstraints { make in
            make.height.width.equalTo(dotHeight)
            make.top.equalTo(identifiedDot.snp.top)
            make.leading.equalTo(hospitalizedLabel.snp.trailing).offset(20)
        }
        recoveredDot.layer.cornerRadius = CGFloat(dotHeight/2)
        addSubview(recoveredLabel)
        recoveredLabel.snp.makeConstraints { make in
            make.leading.equalTo(recoveredDot.snp.trailing).offset(7)
            make.centerY.equalTo(identifiedDot.snp.centerY)
        }
    }
    
    private func setupChartSegment() {
        setupChartContainer()
        setupSeriesContainersInOrder()
    }
    
    private func setupChartContainer() {
        addSubview(chartContainer)
        chartContainer.snp.makeConstraints { make in
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.bottom.equalTo(-20)
            make.top.equalTo(identifiedDot.snp.bottom).offset(20)
        }
        chartContainer.addSubview(chartSeparatorView)
        chartSeparatorView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(chartContainer)
            make.height.equalTo(3)
            make.bottom.equalTo(-40)
        }
    }
    
    private func setupSeriesContainersInOrder() {
        let citiesDataArray = chartData.xAxisValues
        seriesStackView.axis = .horizontal
        seriesStackView.distribution = .fillEqually
        layoutStackView(seriesStackView)

        for i in 1...citiesDataArray.count {
            guard let cityId: Int = chartData.xAxisValueWithOrder(i)?.id else { continue }
            let cityContainer = SeriesContainer(chartView: self, cityId: cityId)
            seriesStackView.addArrangedSubview(cityContainer)
        }
    }
    
    private func layoutStackView(_ stackView: UIStackView) {
        chartContainer.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalTo(chartContainer)
            make.width.equalTo(chartContainer).multipliedBy(0.9)
        }
    }
    
    override func layoutSubviews() {
        let dynamicSpacing = seriesStackView.bounds.width / 7
        seriesStackView.spacing = dynamicSpacing
    }
}






    


