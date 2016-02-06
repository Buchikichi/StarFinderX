//
//  SpaceView.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/06.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//

import UIKit

class SpaceView: UIView {
    var starArray : Array<Star> = []
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

    override func drawRect(rect: CGRect) {
        if self.starArray.count == 0 {
            return
        }
        let rhRad = self.rotationH * M_PI / 180;
        let rvRad = self.rotationV * M_PI / 180;
        let radius = self.radius * self.magnification
        let centerX = rect.width / 2
        let centerY = rect.height / 2

        var cnt = 0
        for star in self.starArray {
            if (400 < star.v) {
                continue
            }
            let pos = star.calcPos(rhRad, rvRad: rvRad, radius: radius)

            if (pos != nil) {
                let pt = CGPointMake(centerX + pos!.x,centerY + pos!.y)
                let r = CGFloat(star.ratio * 1.5)
                let arc = UIBezierPath(arcCenter: pt, radius: r, startAngle: 0.0, endAngle: CGFloat(M_PI * 2), clockwise: true)
                
                star.color.setFill()
                arc.fill()
                cnt++;
            }
        }
        print("cnt:" + String(cnt))
    }
}
