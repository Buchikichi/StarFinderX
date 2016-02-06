//
//  StarCatalogue.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/06.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//

import UIKit

class StarCatalogue: NSObject {
    static let STARS = 118217

    /**
     * Load the Star Catalogue.
     */
    func load() -> Array<Star> {
        var starArray = [Star]()
        let path = NSBundle.mainBundle().pathForResource("hipparcos", ofType: "json")!
        let data = NSData(contentsOfFile: path)
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSArray
            
            for rec in json {
                let dic = rec as! NSDictionary
                let id = dic["id"] as! Int
                let ra = dic["ra"] as! Double
                let dec = dic["dec"] as! Double
                let v = dic["v"] as! Int
                let s = dic["s"]
                let spect = s?.isKindOfClass(NSNull) == true ? "" : s as! String
                let color = AstroUtils.getColor(spect, v: v)
                let ratio = AstroUtils.calcRatio(v)
                let star = Star(id:id, ra: ra, dec: dec, v: v, color: color, ratio: ratio)

                starArray.append(star)
            }
        } catch {
            print("error!")
        }
        return starArray
    }
}
