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

public class FKPaperFoldingTransitioning: FKFakeTransition, FKFakeTransitioning {
    
    public var navigationBarHeight: CGFloat = 64
    public var foldingFromY: CGFloat = UIScreen.main.bounds.size.height / 2
    
    private var prepared = false
    
    private var animationView: UIView!
    private var navigationBarImageView: UIImageView!
    private var viewTopImageView: UIImageView!
    private var viewBottomImageView: UIImageView!
    
    public func prepareFakeTransitioning() {
        let windowWidth = self.window.bounds.width
        let windowHeight = self.window.bounds.height
        
        animationView = UIView(frame: window.bounds)
        animationView.backgroundColor = UIColor.black
        
        let viewTopImage = self.shotWindow(CGRect(x: 0, y: self.navigationBarHeight, width: windowWidth, height: self.foldingFromY - self.navigationBarHeight))
        viewTopImageView = UIImageView(image: viewTopImage)
        viewTopImageView.frame = CGRect(x: 0, y: self.navigationBarHeight, width: windowWidth, height: self.foldingFromY - self.navigationBarHeight)
        animationView.addSubview(viewTopImageView)
        
        let viewBottomImage = self.shotWindow(CGRect(x: 0, y: self.foldingFromY, width: windowWidth, height: windowHeight - self.foldingFromY))
        viewBottomImageView = UIImageView(image: viewBottomImage)
        viewBottomImageView.frame = CGRect(x: 0, y: self.foldingFromY, width: windowWidth, height: windowHeight - self.foldingFromY)
        animationView.addSubview(viewBottomImageView)
        
        let navigationBarImage = self.shotWindow(CGRect(x: 0, y: 0, width: windowWidth, height: self.navigationBarHeight))
        navigationBarImageView = UIImageView(image: navigationBarImage)
        navigationBarImageView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: self.navigationBarHeight)
        animationView.addSubview(navigationBarImageView)
        
        self.window.addSubview(animationView)
        
        self.prepared = true
    }
    
    public func performFakeTransitioning() {
        if !self.prepared {
            print("ERROR: prepareFakeTransitioning should call before preformFakeTransitioning!")
            return
        }
        
        
    }
}
