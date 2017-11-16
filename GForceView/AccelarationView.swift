//
//  AccelarationView.swift
//  GForceView
//
//  Created by Grzegorz Makowski on 02.11.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import UIKit

enum QuarterType: Int {
    case XNegativeYPositive = 1
    case XPositiveYPositive = 2
    case XPositiveYNegative = 3
    case XNegativeYNegative = 4
}

public struct CGPolygon {
//    public let a: CGPoint
//    public let b: CGPoint
//    public let c: CGPoint

}

public struct PolygonData {

    public var points: [CGPoint] = []
    var bezierPath: UIBezierPath
    var quarterType: QuarterType
}

class AccelarationView: UIView {
    var accuracy = 2
    var allPoints: [CGPoint] = []
    var polygons: [PolygonData] = []
    var polygonBeziers: [UIBezierPath] = []

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        print("touch \(String(describing: location?.x)) \(String(describing: location?.y))")

        let bezier = polygonBeziers[0]
        if let location = location {
            if bezier.contains(location) {
                print("nalezy kurwa")
            } else {
                print("nie nalezy")

            }

        }
    }

    func readPolygons() {
        let halfWidth = self.bounds.size.width / 2
        let center = CGPoint(x: halfWidth, y: halfWidth)
        let quarterWidth = halfWidth / 2
        //QuarterXNegativeYPositive

//        let polygonData1 = PolygonData(points: [CGPoint(x: 0, y: quarterWidth), CGPoint(x: 0, y: halfWidth), center], bezierPath: UIBezierPath(), quarterType: .XNegativeYPositive)
//        polygons.append(polygonData1)

        for index in 1...accuracy {
            if accuracy == 1 {
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: halfWidth))
                path.addLine(to: center)
                path.addLine(to: CGPoint(x: halfWidth, y: 0))
                path.close()
                let polygonData1 = PolygonData(points: [], bezierPath: path, quarterType: .XNegativeYPositive)
                polygons.append(polygonData1)
            } else if accuracy == 2 {
                if index == 1 {
                let path1 = UIBezierPath()
                path1.move(to: CGPoint(x: 0, y: 0))
                path1.addLine(to: CGPoint(x: 0, y: halfWidth))
                path1.addLine(to: center)
                path1.close()
                let polygonData1 = PolygonData(points: [], bezierPath: path1, quarterType: .XNegativeYPositive)
                polygons.append(polygonData1)
                }
                if index == 2 {
                let path2 = UIBezierPath()
                path2.move(to: CGPoint(x: 0, y: 0))
                path2.addLine(to: CGPoint(x: halfWidth, y: 0))
                path2.addLine(to: center)
                path2.close()
                
                let polygonData2 = PolygonData(points: [], bezierPath: path2, quarterType: .XNegativeYPositive)
                polygons.append(polygonData2)
                }
            } else {

            }
            print("tu licze")
        }

    }

    func createPolygonBeziers() {
        for polygonData in polygons {
            let layer = CAShapeLayer()
            layer.path = polygonData.bezierPath.cgPath
            layer.fillColor = getRandomColor().cgColor
            self.layer.addSublayer(layer)
        }
//        let polygonData = polygons[0]
//        let path = UIBezierPath()
//        for index in 0..<polygonData.points.count {
//            if index == 0 {
//                path.move(to: polygonData.points[index])
//            } else {
//                path.addLine(to: polygonData.points[index])
//            }
//        }
//        path.close()
//
//        polygonBeziers.append(path)
        
        
    }


}

extension AccelarationView {
    open func getRandomColor() -> UIColor {

        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)

    }
}
