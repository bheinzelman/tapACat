//
//  boardView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/14/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit

class boardView: UIView {

    init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }

    override func drawRect(rect: CGRect){
        let bounds: CGRect = self.bounds
        var startPoint:CGPoint = CGPoint()
        var endPoint:CGPoint = CGPoint()
    
        startPoint.y = 142.0
        startPoint.x = 0.0
        endPoint.y = 142.0
        endPoint.x = 320.0
        var path = UIBezierPath()
        path.lineWidth = 3
        
        while (startPoint.y < 600){
            path.moveToPoint(startPoint)
            path.addLineToPoint(endPoint)
            path.stroke()
            startPoint.y += 106.0
            endPoint.y += 106.0
            
        }
        startPoint.y = 142
        startPoint.x = 0
        endPoint.y = 600
        endPoint.x = 0
        while (startPoint.x < 320){
            path.moveToPoint(startPoint)
            path.addLineToPoint(endPoint)
            path.stroke()
            startPoint.x += 106
            endPoint.x += 106
        }
    }
    

}
