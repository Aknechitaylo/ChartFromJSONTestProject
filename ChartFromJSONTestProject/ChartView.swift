//
//  ChartView.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import UIKit
import SnapKit

class ChartView: UIView {
    private let viewModel: ChartViewModel
    private let chartContainer = UIView()
    private let chartSeparatorView = UIView(color: .systemGray4)
    private let seriesStackView = UIStackView()
    private lazy var dotsStackView: UIStackView = {
        let dotsStackView = UIStackView()
        dotsStackView.spacing = 20
        dotsStackView.axis = .horizontal
        viewModel.chartData.sortedSeries.forEach { series in
            dotsStackView.addArrangedSubview(dotContainer(text: series.name, color: UIColor(rgbString: series.color)))
        }
        return dotsStackView
    }()

    init(chartViewModel: ChartViewModel) {
        self.viewModel = chartViewModel
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
        let dotsContainerStaticHeight = 20
        addSubview(dotsStackView)
        dotsStackView.snp.makeConstraints { make in
            make.leading.equalTo(35)
            make.top.equalTo(20)
            make.height.equalTo(dotsContainerStaticHeight)
        }
    }
    
    private func dotContainer(text: String, color: UIColor) -> UIView {
        let container = UIView()
        let dotView = UIView(color: color)
        let dotHeight = 15
        let label = UILabel(text: text, color: .systemGray)
        let textSize = label.intrinsicContentSize

        container.addSubview(dotView)
        dotView.snp.makeConstraints { make in
            make.height.width.equalTo(dotHeight)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        dotView.layer.cornerRadius = CGFloat(dotHeight/2)
        
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(dotView.snp.trailing).offset(7)
            make.trailing.equalToSuperview()
            make.width.equalTo(textSize.width)
            make.centerY.equalTo(dotView.snp.centerY)
        }
        
        return container
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
            make.top.equalTo(dotsStackView.snp.bottom).offset(20)
        }
        chartContainer.addSubview(chartSeparatorView)
        chartSeparatorView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(chartContainer)
            make.height.equalTo(3)
            make.bottom.equalTo(-40)
        }
    }
    
    private func setupSeriesContainersInOrder() {
        let citiesDataArray = viewModel.chartData.getXAxisValues()
        seriesStackView.axis = .horizontal
        seriesStackView.distribution = .fillEqually
        layoutStackView(seriesStackView)

        for i in 1...citiesDataArray.count {
            guard let cityId: Int = viewModel.chartData.xAxisValueWithOrder(i)?.id else { continue }
            let cityContainer = SeriesContainer(chartViewModel: viewModel, cityId: cityId)
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






    


