//
//  DownwardSpiralTests.swift
//  DownwardSpiralTests
//
//  Created by Peter Respondek on 25/3/19.
//  Copyright © 2019 Peter Respondek. All rights reserved.
//

import XCTest
@testable import DownwardSpiral

class DownwardSpiralTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBadJsonFile() {
        XCTAssertThrowsError(try GraphModel(jsonUrl: "foo.bar"))
    }
    
    func testBadJsonData1() {
        let bad = Dictionary<String,Array<Int>>()
        XCTAssertThrowsError(try GraphModel(rawData: bad))
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
