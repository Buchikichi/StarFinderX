//
//  Star.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/06.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//
import UIKit

struct Star {
    var id: Int
    var ra: Double
    var dec: Double
    var v: Int
    var color: UIColor
    var ratio: Double

    func calcPos(rhRad: Double, rvRad: Double, radius: Double) -> CGPoint? {
        var ptX = 0.0
        var ptY = 0.0
        var wx = ptX
        var wz = radius
        let raRad = self.ra + rhRad
        let radX = rvRad
        let decRad = self.dec
        let radZ = 0.0
        var wy = -sin(decRad) * wz

        wz = cos(decRad) * wz;
        ptX = -sin(raRad) * wz;
        wz = cos(raRad) * wz;
        ptY = cos(radX) * wy - sin(radX) * wz;

        let z = sin(radX) * wy + cos(radX) * wz;

        if (z < 0) {
            return nil;
        }
        wx = ptX;
        wy = ptY;
        let x = cos(radZ) * wx - sin(radZ) * wy;
        let y = sin(radZ) * wx + cos(radZ) * wy;

        return CGPoint(x: x, y: y)
    }
}
