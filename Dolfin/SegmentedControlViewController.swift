//
//  SegmentedControlViewController.swift
//  Dolfin
//
//  Created by igor on 03.12.2020.
//

import Foundation
import UIKit

class SegmentedControlViewController: UIViewController {
    
    @IBOutlet weak var diagrama: UIView!
    @IBOutlet weak var grafic: UIView!
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diagrama.isHidden = false
        grafic.isHidden = true
        self.segmentButton.addTarget(self, action: #selector(goToCertainView(sender:)), for: .valueChanged)
    }
    
    @objc func goToCertainView(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            grafic.isHidden = true
            diagrama.isHidden = false
        } else if index == 1 {
            grafic.isHidden = false
            diagrama.isHidden = true
        }
    }
    
}

class Diagrama: UIView {
    var brownC: CGFloat = 5.0
    var lightBlueC: CGFloat = 5.0
    var orangeC: CGFloat = 10.0
    var blueC: CGFloat = 80.0
    
    override func draw(_ rect: CGRect) {
        let rad: CGFloat = 88.0
        let brown = UIBezierPath()
        let lightBlue = UIBezierPath()
        let orange = UIBezierPath()
        let blue = UIBezierPath()
        brown.lineWidth = 35.0
        lightBlue.lineWidth = 35.0
        orange.lineWidth = 35.0
        blue.lineWidth = 35.0
        brown.addArc(withCenter: CGPoint(x: self.bounds.width/CGFloat(2.0), y: self.bounds.height/CGFloat(2.4)), radius: rad, startAngle: 0, endAngle: 2*CGFloat.pi*brownC/100, clockwise: true)
        lightBlue.addArc(withCenter: CGPoint(x: self.bounds.width/CGFloat(2.0), y: self.bounds.height/CGFloat(2.4)), radius: rad, startAngle: 2*CGFloat.pi*brownC/100, endAngle: 2*CGFloat.pi*(brownC+lightBlueC)/100, clockwise: true)
        orange.addArc(withCenter: CGPoint(x: self.bounds.width/CGFloat(2.0), y: self.bounds.height/CGFloat(2.4)), radius: rad, startAngle: 2*CGFloat.pi*(brownC+lightBlueC)/100, endAngle: 2*CGFloat.pi*(brownC+lightBlueC+orangeC)/100, clockwise: true)
        blue.addArc(withCenter: CGPoint(x: self.bounds.width/CGFloat(2.0), y: self.bounds.height/CGFloat(2.4)), radius: rad, startAngle: 2*CGFloat.pi*(brownC+lightBlueC+orangeC)/100, endAngle: 2*CGFloat.pi*(brownC+lightBlueC+orangeC+blueC)/100, clockwise: true)
        UIColor.brown.setStroke()
        brown.stroke()
        UIColor.systemBlue.setStroke()
        lightBlue.stroke()
        UIColor.orange.setStroke()
        orange.stroke()
        UIColor.blue.setStroke()
        blue.stroke()
    }
}

class Grafic: UIView {
    var dependence: ((Float) -> Float)?
    var set: CGPoint?
    var origin: CGPoint {
        get {
            return set ?? CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        }
        set {
            set = newValue
        }
    }
    override func draw(_ rect: CGRect) {
        let graphAxes = ShowXY()
        graphAxes.contentScaleFactor = contentScaleFactor
        graphAxes.color = UIColor.red
        graphAxes.drawAxes(in: bounds, origin: origin, pointsPerUnit: 25.85)
        drawGrafic(bounds, origin: origin, scale: 25.85)
    }
    
    func drawGrafic(_ bounds: CGRect, origin: CGPoint, scale: CGFloat) {
            var xGraph, yGraph: CGFloat
            var x, y: Float
            var isFirstPoint = true
            
            let oldYGraph: CGFloat = 0.0
            var disContinuity: Bool {
                return abs(yGraph - oldYGraph) > max(bounds.width, bounds.height) * 1.5
            }
            dependence = {log($0)}
            if dependence != nil {
                UIColor.black.set()
                let path = UIBezierPath()
                path.lineWidth = 1.0
                
                var xArray: [Float] = []
                for i in -4...4 {
                    xArray.append(Float(i))
                    if i == 4 {
                        break
                    }
                    for _ in 0...4 {
                        xArray.append(Float(0))
                    }
                }
                var i: Int = 0
                while i < xArray.count {
                    if Int(xArray[i]) == 4 {
                        break
                    }
                    xArray[i + 1] = xArray[i] + 0.15
                    xArray[i + 2] = xArray[i] + 0.3
                    xArray[i + 3] = xArray[i] + 0.55
                    xArray[i + 4] = xArray[i] + 0.75
                    xArray[i + 5] = xArray[i] + 0.92
                    i = i + 6
                }
                for i in xArray{
                    x = Float(i)
                    xGraph = CGFloat(x) * scale + origin.x
                    y = (dependence)!(x)
                    guard y.isFinite else {
                        continue
                    }
                    yGraph = origin.y - CGFloat(y) * scale
                    if isFirstPoint {
                        path.move(to: CGPoint(x: xGraph, y: yGraph))
                        isFirstPoint = false
                    } else {
                        if disContinuity {
                            isFirstPoint = true
                        } else {
                            path.addLine(to: CGPoint(x: xGraph, y: yGraph))
                        }
                    }
                }
                path.stroke()
            }
        }
}
