//
//  boardView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/14/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit

class boardView: UIView {
    

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    override func drawRect(rect: CGRect){
        let bounds: CGRect = self.bounds
        var startPoint:CGPoint = CGPoint()
        var endPoint:CGPoint = CGPoint()
        let sizes = self.bounds.size
        startPoint.y = 0.0
        startPoint.x = 0.0
        endPoint.y = 0.0
        endPoint.x = sizes.width
        var path = UIBezierPath()
        path.lineWidth = 3
        
        var i = 0
        while (startPoint.y <= sizes.height){
            if (i == 0) {
                path.lineWidth = 4
            }
            else {
                path.lineWidth = 3
            }
            path.moveToPoint(startPoint)
            path.addLineToPoint(endPoint)
            path.stroke()
            startPoint.y += (sizes.height/4)
            endPoint.y += (sizes.height/4)
            i++
            
        }
        startPoint.y = 0
        startPoint.x = 0
        endPoint.y = sizes.height
        endPoint.x = 0
        while (startPoint.x <= sizes.width){
            path.moveToPoint(startPoint)
            path.addLineToPoint(endPoint)
            path.stroke()
            startPoint.x += (sizes.width/3)
            endPoint.x += (sizes.width/3)
        }
    }
    

}
