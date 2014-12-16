//
//  HighScoreView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/23/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit

class HighScoreView: UIView {

    init() {
        let frame = CGRectMake(0, 92, 320, 428)
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    override func drawRect(rect: CGRect)
    {
        var start = CGPoint()
        var end = CGPoint()
        var path = UIBezierPath()
        start.x = 0
        start.y = 0
        end.x = 320
        end.y = 0
        path.lineWidth = 2
        while (start.y < 550) {
            path.lineWidth = 2
            path.moveToPoint(start)
            path.addLineToPoint(end)
            path.stroke()
            start.y += 42.8
            end.y += 42.8
            
        }
    }
}
