//
//  Parser.swift
//  ChartFromJSONTestProject
//
//  Created by Andrei Nechitailo on 20.12.2022.
//

import Foundation

struct ChartData: Codable {
    let series: [Series]
    let xAxisValues: [XAxisValue]
    let yAxisValues: [YAxisValue]
    
    func seriesWithId(_ id: Int) -> Series? {
        return series.first(where: {$0.id == id})
    }
    
    func xAxisValueWithId(_ id: Int) -> XAxisValue? {
        return xAxisValues.first(where: {$0.id == id})
    }
    
    func xAxisValueWithOrder(_ order: Int) -> XAxisValue? {
        return xAxisValues.first(where: {$0.ord == order})
    }
    
    func yAxisValue(seriesId: Int, cityId: Int) -> YAxisValue? {
        return yAxisValues.first(where: {$0.seriesId == seriesId && $0.xAxisValueId == cityId})
    }
}

struct Series: Codable {
    let name: String
    let id, ord: Int
    let color: String
}

struct XAxisValue: Codable {
    let name: String
    let id, ord: Int
}

struct YAxisValue: Codable {
    let seriesId, xAxisValueId, value: Int
}

class Parser {
    static func parseJSON(jsonData: Data) -> ChartData? {
        var result: ChartData?
        do {
            result = try JSONDecoder().decode(ChartData.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }
}
