//
//  Parser.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import Foundation

struct ChartData: Decodable {
    private let series: [Series]
    private let xAxisValues: [XAxisValue]
    private let yAxisValues: [YAxisValue]
    var seriesCount: Int {
        series.count
    }
    
    func seriesWithId(_ id: Int) -> Series? {
        series.first(where: {$0.id == id})
    }
    
    func seriesWithOrder(_ order: Int) -> Series? {
        series.first(where: {$0.ord == order})
    }
    
    func getXAxisValues() -> [XAxisValue] {
        self.xAxisValues
    }
    
    func xAxisValueWithId(_ id: Int) -> XAxisValue? {
        xAxisValues.first(where: {$0.id == id})
    }
    
    func xAxisValueWithOrder(_ order: Int) -> XAxisValue? {
        xAxisValues.first(where: {$0.ord == order})
    }
    
    func yAxisValue(seriesId: Int, cityId: Int) -> YAxisValue? {
        yAxisValues.first(where: {$0.seriesId == seriesId && $0.xAxisValueId == cityId})
    }
}

struct Series: Decodable {
    let name: String
    let id, ord: Int
    let color: String
    static let `default` = Series(name: "", id: 0, ord: 0, color: "")
}

struct XAxisValue: Decodable {
    let name: String
    let id, ord: Int
}

struct YAxisValue: Decodable {
    let seriesId, xAxisValueId, value: Int
}

enum Parser {
    static func parseJSON(jsonData: Data) -> ChartData? {
        do {
            return try JSONDecoder().decode(ChartData.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
