//
//  AstroUtils.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/06.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//

import UIKit

class AstroUtils: NSObject {
    static let MIN_V = -144
    static let MAX_V = 1408
    static let V_WIDTH = MAX_V - MIN_V

//    static func toRaDeg(ra: String) -> Double {
//        let item = ra.componentsSeparatedByString(" ")
//        let hh = Double(item[0])! * 3600
//        let mm = Double(item[1])! * 60
//
//        return (Double(item[2])! + hh + mm) / 240
//    }
//
//    static func toDecDeg(dec: String) -> Double {
//        let item = dec.componentsSeparatedByString(" ")
//        let hh = item[0]
//        let mm = Double(item[1])! * 60
//        var val = Double(item[2])! + mm
//
//        if hh.characters.startsWith("-".characters) {
//            val = -val
//        }
//        return val / 3600 + Double(hh)!
//    }
//
//    static func toRaRad(ra: String) -> Double {
//        return toRaDeg(ra) * M_PI / 180
//    }
//
//    static func toDecRad(dec: String) -> Double {
//        return toDecDeg(dec) * M_PI / 180
//    }

    static func calcRatio(v: Int) -> Double {
        return Double(V_WIDTH - (v - MIN_V)) / Double(V_WIDTH)
    }

    static func getColor(spect: String, v: Int) -> UIColor {
        let ratio = calcRatio(v)
        let alpha = CGFloat(ratio * 0.6)
        let sp = spect
        var color = UIColor(red: 0.13, green: 0.13, blue: 0.8, alpha: alpha)

        if (sp == "O") {
            color = UIColor(red: 0.35, green: 0.6, blue: 1.0, alpha: alpha)
        } else if (sp == "B") {
            color = UIColor(red: 0.74, green: 1.0, blue: 1.0, alpha: alpha)
        } else if (sp == "A") {
            color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alpha)
        } else if (sp == "F") {
            color = UIColor(red: 1.0, green: 1.0, blue: 0.4, alpha: alpha)
        } else if (sp == "G") {
            color = UIColor(red: 1.0, green: 1.0, blue: 0.13, alpha: alpha)
        } else if (sp == "K") {
            color = UIColor(red: 1.0, green: 0.53, blue: 0.26, alpha: alpha)
        } else if (sp == "M") {
            color = UIColor(red: 1.0, green: 0.31, blue: 0.31, alpha: alpha)
        }
        return color
    }
}
