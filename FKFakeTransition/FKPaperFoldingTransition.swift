//
//  FKPaperFoldingTransition.swift
//  FKFakeTransition
//
//  Created by FlyKite on 2017/7/29.
//  Copyright © 2017年 FlyKite. All rights reserved.
//

import UIKit

public class FKPaperFoldingTransition: NSObject, FKFakeTransitionCreator {
    
    public static func create(with keyWindow: UIWindow) -> FKFakeTransitioning {
        let transition = FKPaperFoldingTransitioning(keyWindow)
        return transition
    }
}

public class FKPaperFoldingTransitioning: FKFakeTransition, FKFakeTransitioning, CAAnimationDelegate {
    
    public var duration: Double = 10
    public var navigationBarFromHeight: CGFloat = 0
    public var navigationBarToHeight: CGFloat = 0
    public var foldingFromY: CGFloat = UIScreen.main.bounds.size.height / 2
    
    private var prepared = false
    
    private var animationView: UIView!
    private var fromNavigationBarImageView: UIImageView!
    private var fromViewTopImageView: UIImageView!
    private var fromViewBottomImageView: UIImageView!
    private var toNavigationBarImageView: UIImageView!
    private var toViewTopImageView: UIImageView!
    private var toViewBottomImageView: UIImageView!
    
    public func prepareFakeTransitioning() {
        let windowWidth = self.window.bounds.width
        let windowHeight = self.window.bounds.height
        
        animationView = UIView(frame: window.bounds)
        animationView.backgroundColor = UIColor.black
        
        let viewTopImage = self.shotWindow(CGRect(x: 0, y: self.navigationBarFromHeight, width: windowWidth, height: self.foldingFromY - self.navigationBarFromHeight))
        fromViewTopImageView = UIImageView(image: viewTopImage)
        fromViewTopImageView.frame = CGRect(x: 0, y: self.navigationBarFromHeight, width: windowWidth, height: self.foldingFromY - self.navigationBarFromHeight)
        animationView.addSubview(fromViewTopImageView)
        
        let viewBottomImage = self.shotWindow(CGRect(x: 0, y: self.foldingFromY, width: windowWidth, height: windowHeight - self.foldingFromY))
        fromViewBottomImageView = UIImageView(image: viewBottomImage)
        fromViewBottomImageView.frame = CGRect(x: 0, y: self.foldingFromY, width: windowWidth, height: windowHeight - self.foldingFromY)
        animationView.addSubview(fromViewBottomImageView)
        
        let navigationBarImage = self.shotWindow(CGRect(x: 0, y: 0, width: windowWidth, height: self.navigationBarFromHeight))
        fromNavigationBarImageView = UIImageView(image: navigationBarImage)
        fromNavigationBarImageView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: self.navigationBarFromHeight)
        animationView.addSubview(fromNavigationBarImageView)
        
        self.window.addSubview(animationView)
        
        self.prepared = true
    }
    
    public func performFakeTransitioning() {
        if !self.prepared {
            print("ERROR: prepareFakeTransitioning should call before preformFakeTransitioning!")
            return
        }
        let windowWidth = self.window.bounds.width
        let windowHeight = self.window.bounds.height
        
        animationView.removeFromSuperview()
        
        let viewTopImage = self.shotWindow(CGRect(x: 0, y: self.navigationBarToHeight, width: windowWidth, height: (windowHeight - self.navigationBarToHeight) / 2))
        toViewTopImageView = UIImageView(image: viewTopImage)
        toViewTopImageView.frame = CGRect(x: 0, y: self.navigationBarToHeight, width: windowWidth, height: (windowHeight - self.navigationBarToHeight) / 2)
        animationView.addSubview(toViewTopImageView)
        
        let viewBottomImage = self.shotWindow(CGRect(x: 0, y: self.navigationBarToHeight + (windowHeight - self.navigationBarToHeight) / 2, width: windowWidth, height: (windowHeight - self.navigationBarToHeight) / 2))
        toViewBottomImageView = UIImageView(image: viewBottomImage)
        toViewBottomImageView.frame = CGRect(x: 0, y: self.navigationBarToHeight + (windowHeight - self.navigationBarToHeight) / 2, width: windowWidth, height: (windowHeight - self.navigationBarToHeight) / 2)
        animationView.addSubview(toViewBottomImageView)
        
        let navigationBarImage = self.shotWindow(CGRect(x: 0, y: 0, width: windowWidth, height: self.navigationBarToHeight))
        toNavigationBarImageView = UIImageView(image: navigationBarImage)
        toNavigationBarImageView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: self.navigationBarToHeight)
        animationView.addSubview(toNavigationBarImageView)
        
        self.window.addSubview(animationView)
        
        let navigationAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        navigationAlphaAnimation.fromValue = 0
        navigationAlphaAnimation.toValue = 1
        navigationAlphaAnimation.duration = duration
        toNavigationBarImageView.layer.add(navigationAlphaAnimation, forKey: nil)
        
        let fromViewTopPosition = CABasicAnimation(keyPath: "position.y")
        fromViewTopPosition.fromValue = self.navigationBarFromHeight + (self.foldingFromY - self.navigationBarFromHeight) / 2
        fromViewTopPosition.toValue = self.navigationBarFromHeight - (self.foldingFromY - self.navigationBarFromHeight) / 2
        let fromViewTopAlpha = CABasicAnimation(keyPath: "opacity")
        fromViewTopAlpha.fromValue = 1
        fromViewTopAlpha.toValue = 0.5
        let fromViewTopAnimation = CAAnimationGroup()
        fromViewTopAnimation.animations = [fromViewTopPosition, fromViewTopAlpha]
        fromViewTopAnimation.duration = duration
        fromViewTopAnimation.fillMode = kCAFillModeBoth
        fromViewTopAnimation.isRemovedOnCompletion = false
        fromViewTopImageView.layer.add(fromViewTopAnimation, forKey: nil)
        
        let fromViewBottomPosition = CABasicAnimation(keyPath: "position.y")
        fromViewBottomPosition.fromValue = self.foldingFromY + (windowHeight - self.foldingFromY) / 2
        fromViewBottomPosition.toValue = self.foldingFromY + (windowHeight - self.foldingFromY) / 2 * 3
        let fromViewBottomAlpha = CABasicAnimation(keyPath: "opacity")
        fromViewBottomAlpha.fromValue = 1
        fromViewBottomAlpha.toValue = 0.5
        let fromViewBottomAnimation = CAAnimationGroup()
        fromViewBottomAnimation.animations = [fromViewBottomPosition, fromViewBottomAlpha]
        fromViewBottomAnimation.duration = duration
        fromViewBottomAnimation.fillMode = kCAFillModeBoth
        fromViewBottomAnimation.isRemovedOnCompletion = false
        fromViewBottomImageView.layer.add(fromViewBottomAnimation, forKey: nil)
        
        let toViewTopRotation = CABasicAnimation(keyPath: "transform")
        toViewTopRotation.fromValue = self.rotationTransform(CATransform3DMakeRotation(-CGFloat.pi / 2, 1, 0, 0), 1000)
        toViewTopRotation.toValue = self.rotationTransform(CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 0), 1000)
        let toViewTopPosition = CABasicAnimation(keyPath: "position.y")
        toViewTopPosition.fromValue = self.foldingFromY
        toViewTopPosition.toValue = self.navigationBarToHeight
        let toViewTopAlpha = CABasicAnimation(keyPath: "opacity")
        toViewTopAlpha.fromValue = 0.5
        toViewTopAlpha.toValue = 1
        let toViewTopAnimations = CAAnimationGroup()
        toViewTopAnimations.animations = [toViewTopRotation, toViewTopPosition, toViewTopAlpha]
        toViewTopAnimations.duration = duration
        toViewTopAnimations.fillMode = kCAFillModeBoth
        toViewTopAnimations.isRemovedOnCompletion = false
        toViewTopImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        toViewTopImageView.layer.add(toViewTopAnimations, forKey: nil)
        
        let toViewBottomRotation = CABasicAnimation(keyPath: "transform")
        toViewBottomRotation.fromValue = self.rotationTransform(CATransform3DMakeRotation(CGFloat.pi / 2, 1, 0, 0), 1000)
        toViewBottomRotation.toValue = self.rotationTransform(CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 0), 1000)
        let toViewBottomPosition = CABasicAnimation(keyPath: "position.y")
        toViewBottomPosition.fromValue = self.foldingFromY
        toViewBottomPosition.toValue = windowHeight
        let toViewBottomAnimations = CAAnimationGroup()
        toViewBottomAnimations.animations = [toViewBottomRotation, toViewBottomPosition]
        toViewBottomAnimations.duration = duration
        toViewBottomAnimations.fillMode = kCAFillModeBoth
        toViewBottomAnimations.isRemovedOnCompletion = false
        toViewBottomAnimations.delegate = self
        toViewBottomImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        toViewBottomImageView.layer.add(toViewBottomAnimations, forKey: nil)
        
    }
    
    func rotationTransform(_ t: CATransform3D, _ distanceZ: CGFloat) -> CATransform3D {
        let transToCenter = CATransform3DMakeTranslation(0, 0, 0)
        let transBack = CATransform3DMakeTranslation(0, 0, 0)
        var scale = CATransform3DIdentity
        scale.m34 = -1.0 / distanceZ
        let ts = CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack)
        return CATransform3DConcat(t, ts)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationView.removeFromSuperview()
    }
}
