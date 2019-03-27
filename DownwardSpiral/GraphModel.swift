//
//  GraphModel.swift
//  DownwardSpiral
//
//  Created by Peter Respondek on 27/3/19.
//  Copyright © 2019 Peter Respondek. All rights reserved.
//

import Foundation

protocol GraphRegion {
    var offset : Double { get set }
    var height : Double { get set }

}

struct TargetRegion : GraphRegion {
    var offset: Double
    var height: Double
    
    init (jsonData: Dictionary<String,AnyObject>) {
        self.offset = (jsonData["start"] as? Double ?? 0)
        self.height = (jsonData["ftp"] as? Double ?? 0)
    }
}
enum GraphModelError : Error {
    case DataFormat(String)
}
class GraphModel {
    var regions : Array<GraphRegion>
    
    required init () {
        self.regions = Array<GraphRegion>()
    }
    
    convenience init(jsonUrl: String) throws {
        let json = try JSONSerialization.loadJson(path: jsonUrl)
        try self.init(rawData: json)
    }
    
    internal convenience init(rawData: Any) throws {
        if let formattedData = rawData as? Array<Dictionary<String,AnyObject>> {
            try self.init(formattedData: formattedData)
        } else {
            throw GraphModelError.DataFormat("Incorrect Formatting")
        }
    }
    
    convenience init(formattedData: Array<Dictionary<String,AnyObject>>) throws {
        self.init()
        for element in formattedData {
            let type = element["type"] as? barType ?? .target
            switch type {
                case .target :
                    self.regions.append(TargetRegion(jsonData: element))
            }
        }
    }
    
    var bounds : (Double,Double) {
        var width = 0.0
        var height = 0.0
        regions.forEach { (element: GraphRegion) in
            height = max(element.height, height)
            width = max(element.offset, width)
        }
        return (width,height)
    }
}
