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

struct BarRegion {
    
}

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // I wanted autorotate to work so the setup code is done in viewDidAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let view_dim = graphView.bounds.size
        let graph : GraphModel
        do {
         try graph = GraphModel(jsonUrl: "Assets/DownwardSpiral.json")
        } catch {
            graph = GraphModel()
        }
        let graph_dim = graph.bounds
        
        // find dimensions relative to the view
        let ratio = CGSize(width: view_dim.width / CGFloat(graph_dim.0),
                           height: view_dim.height / CGFloat(graph_dim.1) )
        var prev = CGSize(width:0, height:0)
        
        for element in graph.regions {
            let rect = CGRect( x: prev.width,
                               y: view_dim.height - prev.height,
                               width: CGFloat(element.offset) * ratio.width - prev.width,
                               height: prev.height )
            graphView.addBar(rect)
            prev.width = CGFloat(element.offset) * ratio.width
            prev.height = CGFloat(element.height) * ratio.height
        }
        graphView.setNeedsDisplay()
    }
}

