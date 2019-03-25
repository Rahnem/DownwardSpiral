//
//  GraphView.swift
//  DownwardSpiral
//
//  Created by Peter Respondek on 25/3/19.
//  Copyright © 2019 Peter Respondek. All rights reserved.
//

import Foundation
import UIKit

class GraphView : UIView {
    private var _bars = Array<CGRect>()
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(UIColor.init(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0).cgColor)
        context.move(to: CGPoint(x: 0, y: bounds.size.height))
        for bar in _bars {
            context.addLine(to: bar.origin)
            context.addLine(to: CGPoint(x: bar.origin.x + bar.size.width, y: bar.origin.y))
        }
        context.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        context.closePath()
        context.fillPath()
        
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(2.0)
        context.move(to: CGPoint(x: 0, y: bounds.size.height * 0.5))
        context.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height * 0.5))
        context.strokePath()
    }
    
    func addBar (_ rect: CGRect) {
        _bars.append(rect)
    }
}
