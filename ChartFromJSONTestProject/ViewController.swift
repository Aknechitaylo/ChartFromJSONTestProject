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
    private lazy var deviceWithSafeArea: Bool = {
        UIApplication.shared.windows.first?.safeAreaLayoutGuide.layoutFrame.origin != .zero
    }()
    private var orientation: UIInterfaceOrientation {
        UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .unknown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
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
        chartView?.layer.cornerRadius = (chartView?.frame.height ?? 0) / 18
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if deviceWithSafeArea { layoutChartView() }
    }
    
    private func setupChartView() {
        guard
            let jsonData = dataFromJSON,
            let chartView = MyChartFactory.chart(data: jsonData)
        else { return }
        self.chartView = chartView
        view.addSubview(chartView)
        layoutChartView()
    }
    
    private func layoutChartView() {
        guard let chartView = chartView else { return }
        chartView.snp.remakeConstraints { make in
            if deviceWithSafeArea {
                if (orientation == .landscapeRight) {
                    make.leading.equalTo(view.safeAreaLayoutGuide)
                    make.trailing.equalTo(-25)
                } else {
                    make.trailing.equalTo(view.safeAreaLayoutGuide)
                    make.leading.equalTo(25)
                }
            } else {
                make.leading.equalTo(25)
                make.trailing.equalTo(-25)
            }
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
    }
    
    private func showAlertWithText(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default))
        self.present(alertController, animated: true)
    }
}

