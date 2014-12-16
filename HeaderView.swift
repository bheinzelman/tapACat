//
//  HeaderView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 8/4/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    override func drawRect(rect: CGRect)
    {
        var path = UIBezierPath()
        path.lineWidth = 2
        var start = CGPoint()
        start.x = 0; start.y = 0;
        var end = CGPoint()
        end.x = 0; end.y = self.bounds.size.height;
        path.moveToPoint(start)
        path.addLineToPoint(end)
        path.stroke()
        start = end
        end.x = (self.bounds.size.width)/2
        end.y = self.bounds.size.height
        path.addLineToPoint(end)
        path.stroke()
        start = end
        end.x = (self.bounds.size.width)/2
        end.y = 0
        path.addLineToPoint(end)
        path.stroke()
        start.y = self.bounds.size.height
        end.y = self.bounds.size.height
        end.x = self.bounds.size.width
        path.moveToPoint(start)
        path.addLineToPoint(end)
        path.stroke()
        start = end
        end.x = self.bounds.size.width
        end.y = 0
        path.addLineToPoint(end)
        path.stroke()
        start = end
        end.x = 0
        end.y = 0
        path.moveToPoint(start)
        path.addLineToPoint(end)
        path.stroke()
    }

}
