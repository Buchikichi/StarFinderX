//
//  Constellation.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/07.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//

struct Constellation {
    var name: String
    var pos: Int
    var lines = [ConstLine]()

    init(name: String, pos: Int) {
        self.name = name
        self.pos = pos
    }
}
struct ConstLine {
    var from: Int
    var to: Int
}
