//
//  ViewController.swift
//  GForceView
//
//  Created by Grzegorz Makowski on 02.11.2017.
//  Copyright © 2017 Makdroid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var accView: UIView!
    var accelarationView : AccelarationView!
    let ringShapeLayer = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let angle = 20.0
//        let radians = angle / 180.0 * CGFloat(M_PI)
//        let rotation = CGAffineTransformRotate(accView.transform, radians);
                createRingPath()
        addAccelarationView()
        drawChartLines()
        accView.transform = CGAffineTransform(rotationAngle: .pi / 4)
        accView.layer.cornerRadius = 30
        accView.layer.shadowColor = UIColor.black.cgColor
        accView.layer.shadowOffset = CGSize(width: 3, height: 3)
        accView.layer.shadowOpacity = 0.7
        accView.layer.shadowRadius = 4.0

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateRing()
        accelarationView.readPolygons()
        accelarationView.createPolygonBeziers()
    }
    
    func createRingPath() {
        let bezierPath = UIBezierPath()
        let arcCenter  = CGPoint(x: accView.frame.size.width / 2, y: accView.frame.size.height / 2)
        let radius = accView.frame.size.height / 2 - 30
        bezierPath.addArc(withCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        ringShapeLayer.path = bezierPath.cgPath
        ringShapeLayer.strokeColor = UIColor.white.cgColor
        ringShapeLayer.fillColor = UIColor.clear.cgColor
        ringShapeLayer.lineWidth = 5.0
        ringShapeLayer.lineCap = kCALineCapRound
    }
    
    func animateRing() {
        accView.layer.addSublayer(ringShapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.fromValue = 0.0
        animation.byValue = 1.0
        animation.duration = 0.7
        
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        ringShapeLayer.add(animation, forKey: "drawLineAnimation")
    }
    
    func addAccelarationView() {
        
        let radius = accView.frame.size.height/1.7
        let size = CGSize(width: radius, height: radius)
        accelarationView = AccelarationView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        accelarationView.center = view.center
        accelarationView.backgroundColor = UIColor.yellow.withAlphaComponent(0.1)
        view.addSubview(accelarationView)
    }
    
    func drawChartLines () {
        let halfSize = accelarationView.bounds.size.width / 2
        
        let xPath = UIBezierPath()
        xPath.move(to: CGPoint(x: 0, y: halfSize))
        xPath.addLine(to: CGPoint(x: accelarationView.bounds.size.width, y:halfSize))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = xPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 4.0
        accelarationView.layer.addSublayer(shapeLayer)
        
        let yPath = UIBezierPath()
        yPath.move(to: CGPoint(x: halfSize, y: 0))
        yPath.addLine(to: CGPoint(x: halfSize, y: accelarationView.bounds.size.width))
        
        let shapeYLayer = CAShapeLayer()
        shapeYLayer.path = yPath.cgPath
        shapeYLayer.strokeColor = UIColor.white.cgColor
        shapeYLayer.lineWidth = 4.0
        accelarationView.layer.addSublayer(shapeYLayer)
        
    }

}

