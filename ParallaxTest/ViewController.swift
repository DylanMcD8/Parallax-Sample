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
    @IBOutlet weak var wallpaperImage: UIImageView!
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
        addReverseParallaxToView(view: wallpaperImage, amount: 40)
    }



}

class RectanglesViewController: UIViewController {
    
    @IBOutlet weak var red: UIView!
    @IBOutlet weak var orange: UIView!
    @IBOutlet weak var yellow: UIView!
    @IBOutlet weak var green: UIView!
    @IBOutlet weak var teal: UIView!
    @IBOutlet weak var cyan: UIView!
    @IBOutlet weak var blue: UIView!
    @IBOutlet weak var indigo: UIView!
    
    override func viewDidLoad() {
        addParallaxToView(view: red, amount: 25)
        addParallaxToView(view: orange, amount: 25)
        addParallaxToView(view: yellow, amount: 25)
        addParallaxToView(view: green, amount: 25)
        addParallaxToView(view: teal, amount: 25)
        addParallaxToView(view: cyan, amount: 25)
        addParallaxToView(view: blue, amount: 25)
        addParallaxToView(view: indigo, amount: 25)
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
    
    addShadowParallaxToView(view: view, amount: amount)
}

func addShadowParallaxToView(view: UIView, amount: Float) {
    
    view.layer.masksToBounds = false
    view.layer.cornerRadius = 30
    view.layer.cornerCurve = .continuous
    view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 1)
    view.layer.shadowRadius = 15
    view.layer.shadowOpacity = 0.7
    
    
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

func addReverseParallaxToView(view: UIView, amount: Float) {
    let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    horizontal.minimumRelativeValue = amount
    horizontal.maximumRelativeValue = -amount

    let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
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
