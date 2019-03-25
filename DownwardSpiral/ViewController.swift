//
//  ViewController.swift
//  DownwardSpiral
//
//  Created by Peter Respondek on 25/3/19.
//  Copyright © 2019 Peter Respondek. All rights reserved.
//

import UIKit

enum barType : String {
    case target = "target"
}

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // I wanted autorotate to work so the setup code is done in viewDidAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let json : Array<Dictionary<String,AnyObject>>
        var graph_dim = CGSize(width: 0, height: 0)
        let view_dim = graphView.bounds.size
        
        do {
            json = try JSONSerialization.loadJson(path: "Assets/DownwardSpiral.json") as! Array<Dictionary<String,AnyObject>>
        } catch {
            fatalError("Missing Resource")
        }
        
        // find the max height and width of the graph
        json.forEach { (element: Dictionary<String, AnyObject>) in
            if let new_height = element["ftp"] as? CGFloat {
                graph_dim.height = max(graph_dim.height, new_height)
            }
            if let new_width = element["start"] as? CGFloat {
                graph_dim.width = max(graph_dim.width, new_width)
            }
        }
        
        // find dimensions relative to the view
        let ratio = CGSize(width: view_dim.width / graph_dim.width,
                           height: view_dim.height / graph_dim.height )
        var prev = CGSize(width:0, height:0)
        
        for element in json {
            let type = element["type"] as? barType ?? .target
            
            switch type {
            case .target :
                let x = (element["start"] as? CGFloat ?? 0) * ratio.width
                let y = (element["ftp"] as? CGFloat ?? 0) * ratio.height
                
                let rect = CGRect( x: prev.width,
                                   y: view_dim.height - prev.height,
                                   width: x - prev.width,
                                   height: prev.height )
                graphView.addBar(rect)
                prev.width = x
                prev.height = y
            }
        }
        graphView.setNeedsDisplay()
    }
}

