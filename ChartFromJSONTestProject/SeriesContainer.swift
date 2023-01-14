//
//  SeriesContainer.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 25.12.2022.
//

import Foundation
import UIKit
import SnapKit

class SeriesContainer: UIView {
    let chartViewModel: ChartViewModel
    let cityId: Int
    let upsideLabel: UILabel = UILabel()
    let valuesContainer: UIStackView = UIStackView()
    let downsideLabel: UILabel = UILabel()
    let identifiedCount: CGFloat
    let hospitalizedCount: CGFloat
    let recoveredCount: CGFloat
    let sumCount: CGFloat

    init(chartViewModel: ChartViewModel, cityId: Int) {
        self.chartViewModel = chartViewModel
        self.cityId = cityId
        identifiedCount = CGFloat(chartViewModel.chartData.yAxisValue(seriesId: 100, cityId: cityId)!.value)
        hospitalizedCount = CGFloat(chartViewModel.chartData.yAxisValue(seriesId: 200, cityId: cityId)!.value)
        recoveredCount = CGFloat(chartViewModel.chartData.yAxisValue(seriesId: 300, cityId: cityId)!.value)
        sumCount = identifiedCount + recoveredCount + hospitalizedCount
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(upsideLabel)
        addSubview(valuesContainer)
        addSubview(downsideLabel)
        setupUpsideLabel()
        setupDownsideLabel()
        setupValuesContainer()
    }
    
    private func setupUpsideLabel() {
        upsideLabel.text = String(float: sumCount)
        upsideLabel.font = .boldSystemFont(ofSize: 14)
        upsideLabel.textAlignment = .center
        upsideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupDownsideLabel() {
        let labelText = chartViewModel.chartData.xAxisValueWithId(cityId)?.name
        downsideLabel.text = labelText
        downsideLabel.textColor = .systemGray
        downsideLabel.font = .systemFont(ofSize: 14)
        downsideLabel.textAlignment = .center
        downsideLabel.numberOfLines = 2
        downsideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    
    private func setupValuesContainer() {
        let identifiedView = LabeledView(count: identifiedCount, color: chartViewModel.identifiedColor)
        let hospitalizedView = LabeledView(count: hospitalizedCount, color: chartViewModel.hospitalizedColor)
        let recoveredView = LabeledView(count: recoveredCount, color: chartViewModel.recoveredColor)
    
        valuesContainer.axis = .vertical
        valuesContainer.spacing = 2
        valuesContainer.snp.makeConstraints { make in
            make.top.equalTo(upsideLabel.snp.bottom)
            make.bottom.equalTo(downsideLabel.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        valuesContainer.addArrangedSubview(recoveredView)
        valuesContainer.addArrangedSubview(hospitalizedView)
        valuesContainer.addArrangedSubview(identifiedView)
        identifiedView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(identifiedCount/sumCount)
        }
        hospitalizedView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(hospitalizedCount/sumCount)
        }
    }
}

class LabeledView: UIView {
    let label: UILabel
    
    init(count: CGFloat, color: UIColor) {
        self.label = UILabel(text: String(float: count), color: .white)
        super.init(frame: .zero)
        self.backgroundColor = color
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(label)
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        label.isHidden = label.intrinsicContentSize.height >= frame.height
    }
}
