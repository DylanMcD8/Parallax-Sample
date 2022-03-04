//
//  ViewController.swift
//  ParallaxTest
//
//  Created by Dylan McDonald on 3/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        mainImage.layer.masksToBounds = true
        mainImage.layer.cornerRadius = 30
        mainImage.layer.cornerCurve = .continuous
        
        mainView.layer.masksToBounds = false
        mainView.layer.cornerRadius = 30
        mainView.layer.cornerCurve = .continuous
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 1)
        mainView.layer.shadowRadius = 15
        mainView.layer.shadowOpacity = 0.7
        
        addParallaxToView(view: mainView, amount: 40)
        addShadowParallaxToView(view: mainView, amount: 40)
    }



}



func addParallaxToView(view: UIView, amount: Float) {

    let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    horizontal.minimumRelativeValue = -amount
    horizontal.maximumRelativeValue = amount

    let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
    vertical.minimumRelativeValue = -amount
    vertical.maximumRelativeValue = amount

    let group = UIMotionEffectGroup()
    group.motionEffects = [horizontal, vertical]
    view.addMotionEffect(group)
    
   
    
    NotificationCenter.default.addObserver(forName:  Notification.Name(rawValue: "UpdateParallax") , object: nil, queue: .main) { notification in
        UIView.animate(withDuration: 0.25) {
            view.removeMotionEffect(group)
        }
    }
}

func addShadowParallaxToView(view: UIView, amount: Float) {
    let horizontal = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width", type: .tiltAlongHorizontalAxis)
    horizontal.minimumRelativeValue = amount
    horizontal.maximumRelativeValue = -amount

    let vertical = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height", type: .tiltAlongVerticalAxis)
    vertical.minimumRelativeValue = amount
    vertical.maximumRelativeValue = -amount

    let group = UIMotionEffectGroup()
    group.motionEffects = [horizontal, vertical]
    view.addMotionEffect(group)
    
    NotificationCenter.default.addObserver(forName:  Notification.Name(rawValue: "UpdateParallax") , object: nil, queue: .main) { notification in
        UIView.animate(withDuration: 0.25) {
            view.removeMotionEffect(group)
        }
    }
}

