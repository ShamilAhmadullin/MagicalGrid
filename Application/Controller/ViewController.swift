//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Shamil on 20/02/2019.
//  Copyright © 2019 ShamCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let numberViewPerRow = 15
    fileprivate var randomColorViews: [String: UIView] = [:]
    fileprivate var selectedView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRandomColorViewInLoop()
        addGestureRecognizer()
    }

    fileprivate func setRandomColorViewInLoop() {
        let width = view.frame.width / CGFloat(numberViewPerRow)
        for coordinateY in 0...35 {
            for coordinateX in 0...numberViewPerRow {
                let randomColorView = UIView()
                randomColorView.frame = CGRect(x: CGFloat(coordinateX) * width, y: CGFloat(coordinateY) * width, width: width, height: width)
                randomColorView.backgroundColor = Random.setRandomColor()
                randomColorView.layer.borderWidth = 0.5
                randomColorView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(randomColorView)
                let key = "\(coordinateX)|\(coordinateY)"
                randomColorViews[key] = randomColorView
            }
        }
    }
    
    fileprivate func addGestureRecognizer() {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let width = view.frame.width / CGFloat(numberViewPerRow)
        let location = gesture.location(in: view)
        let locationX = Int(location.x / width)
        let locationY = Int(location.y / width)
        let key = "\(locationX)|\(locationY)"
        guard let randomColorView = randomColorViews[key] else { return }
        checkSelectedViewAndTransform(randomColorView)
        selectedView = randomColorView
        view.bringSubviewToFront(randomColorView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            randomColorView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        })
        checkGestureStateEndedAndTransform(gesture, randomColorView)
    }
    
    fileprivate func checkSelectedViewAndTransform(_ randomColorView: UIView) {
        if selectedView != randomColorView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedView?.layer.transform = CATransform3DIdentity
            })
        }
    }
    
    fileprivate func checkGestureStateEndedAndTransform(_ gesture: UIPanGestureRecognizer, _ randomColorView: UIView) {
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                randomColorView.layer.transform = CATransform3DIdentity
            })
        }
    }
}

