//
//  SquareView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 8/21/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit

class SquareView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect)
    {
        var path = UIBezierPath()
        path.lineWidth = 2
        self.backgroundColor = UIColor.clearColor()
        
        //first down\\
        var start = CGPoint()
        start.x = (rect.size.width * 0.25)
        start.y = 0
        var end = CGPoint()
        end.x = (rect.size.width * 0.25)
        end.y = rect.size.height
        
        path.moveToPoint(start)
        path.addLineToPoint(end)
        //path.stroke()
        
        //second down
        start.x = (rect.size.width * 0.75)
        start.y = 0
        end.x = (rect.size.width * 0.75)
        end.y = (rect.size.height)
        
        path.moveToPoint(start)
        path.addLineToPoint(end)
        //path.stroke()
        
        //first across
        start.x = 0
        start.y = (rect.size.height * 0.25)
        end.x = rect.size.width
        end.y = (rect.size.height * 0.25)
        
        path.moveToPoint(start)
        path.addLineToPoint(end)
        //path.stroke()
        
        //second across
        start.x = 0
        start.y = (rect.size.height * 0.75)
        end.x = rect.size.width
        end.y = (rect.size.height * 0.75)
        
        path.moveToPoint(start)
        path.addLineToPoint(end)
        path.stroke()
    }

}
