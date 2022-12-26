//
//  ViewController.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var dataFromJSON: Data? {
        var jsonData: Data?
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            jsonData = FileManager().contents(atPath: path)
        }
        return jsonData
    }
    private var chartView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupChartView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if chartView == nil {
            showAlertWithText("Ошибка построения модели")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chartView?.layer.cornerRadius = chartView!.frame.height / 18
    }
    
    private func setupChartView() {
        if let jsonData = dataFromJSON {
            if let chartView = MyChartFactory.chart(data: jsonData) {
                self.chartView = chartView
                view.addSubview(chartView)
                layoutChartView()
            }
        }
    }
    
    private func layoutChartView() {
        chartView?.snp.makeConstraints({ make in
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(-25)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        })
    }
    
    private func showAlertWithText(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default))
        self.present(alertController, animated: true)
    }
}

