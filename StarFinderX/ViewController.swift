//
//  ViewController.swift
//  StarFinderX
//
//  Created by ぶちきち on 2016/02/06.
//  Copyright © 2016年 Nekoko Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var spaceView: SpaceView!

    let catalogue = StarCatalogue()
    var lastPos: CGPoint = CGPointMake(0, 0)

    @IBAction func whenPan(sender: UIPanGestureRecognizer) {
        let pos = sender.translationInView(self.spaceView)

        if sender.state == .Began {
            self.lastPos = pos
            return
        }
        let deltaH = Double(self.lastPos.x - pos.x) * 0.5
        let deltaV = Double(self.lastPos.y - pos.y) * 0.5

        if deltaH != 0 {
            self.spaceView.rotateH(deltaH)
        }
        if deltaV != 0 {
            self.spaceView.rotateV(deltaV)
        }
        self.lastPos = pos
    }

    @IBAction func whenPinch(sender: UIPinchGestureRecognizer) {
        print("scale" + String(sender.scale))
        self.spaceView.zoom(Double(sender.scale))
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.spaceView.setNeedsDisplay()
    }

    override func viewDidAppear(animated: Bool) {
        self.progress.progress = 0.1
        self.spaceView.starArray = self.catalogue.load()
        self.progress.hidden = true
        self.indicator.stopAnimating()
        self.indicator.hidden = true
        self.spaceView.setNeedsDisplay()
        self.spaceView.setupWidth()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
