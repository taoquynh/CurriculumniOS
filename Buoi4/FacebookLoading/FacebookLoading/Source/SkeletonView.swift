//
//  SkeletonView.swift
//  FacebookLoading
//
//  Created by Taof on 3/28/19.
//  Copyright © 2019 Taof. All rights reserved.
//

import UIKit

class SkeletonView: UIView {

    var startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    var endLocations: [NSNumber] = [1.0, 1.5, 2.0]
    
    var gradientBackgroundColor: CGColor = UIColor(white: 0.85, alpha: 1.0 ).cgColor
    var gradientMovingColor: CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
    
    var movingAnimationDuration: CFTimeInterval = 0.8
    var delayBetweenAnimationLoops: CFTimeInterval = 1.0
    
    var gradientLayer: CAGradientLayer!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientBackgroundColor, gradientMovingColor, gradientBackgroundColor]
        gradientLayer.locations = self.startLocations
        self.layer.addSublayer((gradientLayer))
        self.gradientLayer = gradientLayer
    }
    
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = self.startLocations
        animation.toValue = self.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }
    
    func stopAnimating() {
        self.gradientLayer.removeAllAnimations()
        self.gradientLayer.removeFromSuperlayer()
    }

}
