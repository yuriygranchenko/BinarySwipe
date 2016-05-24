//
//  BezierPath+Ext.swift
//  BinarySwipe
//
//  Created by Macostik on 5/24/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation

func ^(lhs: CGFloat, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs, y: rhs)
}

func ^(lhs: CGFloat, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs, height: rhs)
}

func ^(lhs: CGPoint, rhs: CGSize) -> CGRect {
    return CGRect(origin: lhs, size: rhs)
}

extension UIBezierPath {
    
    func move(point: CGPoint) -> Self {
        moveToPoint(point)
        return self
    }
    
    func line(point: CGPoint) -> Self {
        addLineToPoint(point)
        return self
    }
    
    func quadCurve(point: CGPoint, controlPoint: CGPoint) -> Self {
        addQuadCurveToPoint(point, controlPoint: controlPoint)
        return self
    }
}
