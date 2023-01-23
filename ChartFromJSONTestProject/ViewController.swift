//
//  ViewController.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var dataFromJSON: Data?
    private lazy var chartView: UIView = {
        guard
            let jsonData = self.dataFromJSON,
            let chartView = MyChartFactory.chart(data: jsonData)
        else {
            let view = UIView()
            view.tag = 1001
            return view
        }
        return chartView
    }()
    private lazy var deviceWithSafeArea: Bool = {
        UIApplication.shared.windows.first?.safeAreaLayoutGuide.layoutFrame.origin != .zero
    }()
    private var orientation: UIInterfaceOrientation {
        UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .unknown
    }
    
    init() {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            self.dataFromJSON = FileManager().contents(atPath: path)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        setupChartView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if chartView.tag == 1001 {
            showAlertWithText("Ошибка построения модели")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chartView.layer.cornerRadius = chartView.frame.height / 18
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if deviceWithSafeArea { layoutChartView() }
    }
    
    private func setupChartView() {
        guard chartView.tag != 1001 else { return }
        view.addSubview(chartView)
        layoutChartView()
    }
    
    private func layoutChartView() {
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

