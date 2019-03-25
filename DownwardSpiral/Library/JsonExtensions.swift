//
//  JsonExtensions.swift
//  DownwardSpiral
//
//  Created by Peter Respondek on 25/3/19.
//  Copyright © 2019 Peter Respondek. All rights reserved.
//

import Foundation

enum JsonError: Error {
    case fileNotFound ( String )
}

extension JSONSerialization {
    static public func loadJson ( path: String ) throws -> Any {
        var url = URL(fileURLWithPath: path)
        guard url.isFileURL else {
            throw JsonError.fileNotFound("Not a file path: " + path)
        }
        
        let file = url.lastPathComponent
        url.deleteLastPathComponent()
        guard let urlpath = Bundle.main.path(forResource: file, ofType: nil, inDirectory: url.path)
            else { throw JsonError.fileNotFound("File not frond: " + path) }
        let data = try Data(contentsOf: URL(fileURLWithPath: urlpath), options: .dataReadingMapped)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return json
    }
}
