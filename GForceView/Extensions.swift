//
//  Extensions.swift
//  GForceView
//
//  Created by Grzegorz Makowski on 02.11.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)
    }
}

extension CGPoint {
    func vector(to p1: CGPoint) -> CGVector {
        return CGVector(dx: p1.x - self.x, dy: p1.y - self.y)
    }
}

extension UIBezierPath {
    func moveCenter(to: CGPoint) -> Self {
        let bound  = self.cgPath.boundingBox
        let center = bounds.center
        
        let zeroedTo = CGPoint(x: to.x - bound.origin.x, y: to.y - bound.origin.y)
        let vector   = center.vector(to: zeroedTo)
        
        return offset(to: CGSize(width: vector.dx, height: vector.dy))
    }
    
    func offset(to offset: CGSize) -> Self {
        let t = CGAffineTransform(translationX: offset.width, y: offset.height)
        self.apply(t)
        return self
    }
    
    func fit(into: CGRect) -> Self {
        let bounds = self.cgPath.boundingBox
        
        let sw     = into.size.width / bounds.width
        let sh     = into.size.height / bounds.height
        let factor = min(sw, max(sh, 0.0))
        
        return scale(x: factor, y: factor)
    }
    
    func scale(x: CGFloat, y: CGFloat) -> Self {
        let scale = CGAffineTransform(scaleX: x, y: y)
        self.apply(scale)
        return self
    }
}
