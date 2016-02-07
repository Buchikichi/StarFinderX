//
//  SpaceView.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/06.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//

import UIKit

class SpaceView: UIView {
    var starArray = [Star]()
    var starMap = [Int: Star]()
    var constArray = [Constellation]()
    var radius = Double(0)
    var rotationH = Double(0)
    var rotationV = Double(0)
    var magnification = 1.0

    func rotateH(delta: Double) {
        self.rotationH += delta
        self.setNeedsDisplay()
    }

    func rotateV(delta: Double) {
        self.rotationV += delta
        self.setNeedsDisplay()
    }

    func zoom(delta: Double) {
        if delta < 1 {
            self.magnification -= 0.1
        } else {
            self.magnification += 0.1
        }
        if self.magnification < 1 {
            self.magnification = 1
        }
        print("magnification:" + String(self.magnification))
        self.setNeedsDisplay()
    }

    func setupWidth() {
        let width = min(self.bounds.width, self.bounds.height)

        self.radius = Double(width) / 2
        self.backgroundColor = UIColor.blackColor()
    }

    private func drawStars(rect: CGRect, rhRad: Double, rvRad: Double, radius: Double) {
        if self.starArray.isEmpty {
            return
        }
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        var cnt = 0

        for star in self.starArray {
            if (400 < star.v) {
                continue
            }
            let pos = star.calcPos(rhRad, rvRad: rvRad, radius: radius)
            //let pos = CGPointMake(CGFloat(rand() % 100), CGFloat(rand() % 100))
            
            if (pos == nil) {
                continue
            }
            let pt = CGPointMake(centerX + pos!.x,centerY + pos!.y)
            //let pt = CGPointMake(centerX + pos.x,centerY + pos.y)
            let r = CGFloat(star.ratio * 2.0)
            let arc = UIBezierPath(arcCenter: pt, radius: r, startAngle: 0.0, endAngle: CGFloat(M_PI * 2), clockwise: true)
            
            star.color.setFill()
            star.color.setStroke()
            arc.fill()
            //                arc.stroke()
            //                CGContextAddRect(ctx, CGRect(x: pt.x, y: pt.y, width: 1, height: 1))
            cnt++;
        }
        print("cnt:" + String(cnt) + "|" + String(rand()))
    }

    private func drawConst(rect: CGRect, rhRad: Double, rvRad: Double, radius: Double) {
        if self.constArray.isEmpty {
            return
        }
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        let attrs = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 10)!,
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSParagraphStyleAttributeName: paragraphStyle,
        ]

        for constellation in self.constArray {
            let cons = self.starMap[constellation.pos]
            let pos = cons!.calcPos(rhRad, rvRad: rvRad, radius: radius)

            if (pos == nil) {
                continue
            }
            let pt = CGPointMake(centerX + pos!.x,centerY + pos!.y)
            let name = constellation.name as NSString

            name.drawAtPoint(pt, withAttributes: attrs)
            UIColor(red: 0.1, green: 0.3, blue: 0.5, alpha: 0.4).setStroke()
            for line in constellation.lines {
                let from = self.starMap[line.from]
                let to = self.starMap[line.to]
                let fromPos = from?.calcPos(rhRad, rvRad: rvRad, radius: radius)
                if (fromPos == nil) {
                    continue
                }
                let toPos = to?.calcPos(rhRad, rvRad: rvRad, radius: radius)
                if (toPos == nil) {
                    continue
                }
                let fromPt = CGPointMake(centerX + fromPos!.x,centerY + fromPos!.y)
                let toPt = CGPointMake(centerX + toPos!.x,centerY + toPos!.y)
                let bp = UIBezierPath()

                bp.moveToPoint(fromPt)
                bp.addLineToPoint(toPt)
                bp.stroke()
            }
        }
    }

    override func drawRect(rect: CGRect) {
        let rhRad = self.rotationH * M_PI / 180;
        let rvRad = self.rotationV * M_PI / 180;
        let radius = self.radius * self.magnification

        drawConst(rect, rhRad: rhRad, rvRad: rvRad, radius: radius)
        drawStars(rect, rhRad: rhRad, rvRad: rvRad, radius: radius)
    }
}
